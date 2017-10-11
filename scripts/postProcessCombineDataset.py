import sys
import csv

INPUT_DDIS = "../data/CombinedDatasetNotConservative.csv"
INPUT_MP = "../data/processed-dikb-ddis.tsv"
INPUT_CLASS_MAPPING = "../data/drug-class-mapping.tsv"

OUTPUT_FILE = "../data/postprocessed-dataset-not-conservative.tsv"
MP_NS = "http://dbmi-icode-01.dbmi.pitt.edu/mp/"

# maps source name in combined dataset to table sources_category
categoryMap = {"FrenchDB": "French National Formulary (Fr.)", "World-Vista":"French National Formulary (Eng. - TESTING)", "HIV": "Liverpool HIV", "HEP": "Liverpool HEP"}

# read MP mapping
# replace old dikb url to MP_NS 
mpMappingD = {}
with open (INPUT_MP,"rb") as mpFile:
    csvReader = csv.DictReader(mpFile, delimiter='\t')
    for row in csvReader:
        if row["asrt"] and row["claim"]:
            mpMappingD[row["asrt"].replace("https","http").strip()] = MP_NS + str(row["claim"].strip())
        if row["evidence"] and row["mp_evidence"]:
            mpMappingD[row["evidence"].replace("https","http").strip()] = MP_NS + str(row["mp_evidence"].strip())


# read drug class mapping
# {"drug name": "drug class"}
drugClassD = {}
with open (INPUT_CLASS_MAPPING,"rb") as classMapFile:
    csvReader = csv.reader(classMapFile, delimiter='\t')
    for row in csvReader:
        if row[2]:
            drugClassD[row[0]] = row[2]

# print mpMappingD

with open(OUTPUT_FILE, 'wb') as outputf:

    with open(INPUT_DDIS,"rU") as csvfile:
        csvReader = csv.DictReader(csvfile, delimiter='\t')        
        
        header = next(csvReader)
        fieldnames = csvReader.fieldnames + ["DrugClass1"] + ["DrugClass2"] + ["drug1ID"] + ["drug2ID"] + ["managementOptions"]

        csvWriter = csv.DictWriter(outputf, fieldnames, delimiter='\t')
        csvWriter.writeheader()

        for row in csvReader:

            if len(row) > 20 and row["object"] and row["precipitant"]:
                
                # handle the cases that one character drug name 
                if not (len(row["object"]) > 1 and len(row["precipitant"]) > 1):
                    continue

                # add drug1ID, drug2ID to row (in Merged-PDDI interactions1 table)
                if row["drug1"]:
                    row["drug1ID"] = row["drug1"].replace("http://bio2rdf.org/drugbank:","")
                if row["drug2"]:
                    row["drug2ID"] = row["drug2"].replace("http://bio2rdf.org/drugbank:","")

                # strip pipe in text
                if row["evidenceStatement"] and '|' in row["evidenceStatement"]:
                    row["evidenceStatement"] = row["evidenceStatement"].replace('|','')

                # append drug obj/precipt class
                if drugClassD.has_key(row["object"].upper()):
                    row["DrugClass1"] = drugClassD[row["object"].upper()]
                else:
                    row["DrugClass1"] = "None"

                if drugClassD.has_key(row["precipitant"].upper()):
                    row["DrugClass2"] = drugClassD[row["precipitant"].upper()]
                else:
                    row["DrugClass2"] = "None"

                # replace assrt, evidence in dikbv1.2 to MP claim and data/statement
                if row["researchStatement"] and row["researchStatement"] != "None":
                    print "test:" + row["researchStatement"].strip()
                    if mpMappingD.has_key(row["researchStatement"].strip()):
                        row["researchStatement"] = mpMappingD[row["researchStatement"].strip()]
                        
                if row["evidence"]:
                    if mpMappingD.has_key(row["evidence"].strip()):
                        row["evidence"] = mpMappingD[row["evidence"].strip()]

                #if not row["managementOptions"] or row["managementOptions"] == "":
                row["managementOptions"] = "None"

                # maps category in source
                if row["source"] in categoryMap:
                    row["source"] = categoryMap[row["source"]]
                
                # print row
                csvWriter.writerow(row)
                
