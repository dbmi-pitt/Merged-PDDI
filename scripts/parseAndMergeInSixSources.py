import sys
import csv

INPUT_DDIS = "../data/CombinedDatasetNotConservativeAllsources.csv"
INPUT_MP = "../data/processed-dikb-ddis.tsv"
INPUT_CLASS_MAPPING = "../data/drug-class-mapping.tsv"

OUTPUT_FILE = "../data/DIKB-6-sources.csv"
MP_NS = "http://dbmi-icode-01.dbmi.pitt.edu/mp/"

# read MP mapping

mpMappingD = {}
with open (INPUT_MP,"rb") as mpFile:
    csvReader = csv.DictReader(mpFile, delimiter='\t')
    for row in csvReader:
        if row["asrt"] and row["claim"]:
            mpMappingD[row["asrt"].replace("https","http").strip()] = MP_NS + str(row["claim"].strip())
        if row["evidence"] and row["mp_evidence"]:
            mpMappingD[row["evidence"].replace("https","http").strip()] = MP_NS + str(row["mp_evidence"].strip())


# read drug class mapping

drugClassD = {}
with open (INPUT_CLASS_MAPPING,"rb") as classMapFile:
    csvReader = csv.reader(classMapFile, delimiter='\t')
    for row in csvReader:
        if row[2]:
            drugClassD[row[0]] = row[2]


print mpMappingD

with open(OUTPUT_FILE, 'wb') as outputf:

    with open(INPUT_DDIS,"rb") as csvfile:
        csvReader = csv.DictReader(csvfile, delimiter='\t')
        header = next(csvReader)
        fieldnames = csvReader.fieldnames + ['DrugClass1'] + ['DrugClass2']

        csvWriter = csv.DictWriter(outputf, fieldnames)
        csvWriter.writeheader()

        for row in csvReader:

            # handle the cases that one character drug name 
            if len(row) > 20 and len(row["object"]) > 1 and len(row["precipitant"]) > 1:

                if row["source"] in ["Drugbank","DIKB","NDF-RT","ONC-HighPriority","ONC-NonInteruptive","CredibleMeds"]:

                    # strip pipe in text
                    if '|' in row["evidenceStatement"]:
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
                    if row["researchStatement"]:
                        print row["researchStatement"].strip()
                        if mpMappingD.has_key(row["researchStatement"].strip()):
                            row["researchStatement"] = mpMappingD[row["researchStatement"].strip()]

                    if row["evidence"]:
                        if mpMappingD.has_key(row["evidence"].strip()):
                            row["evidence"] = mpMappingD[row["evidence"].strip()]

                    csvWriter.writerow(row)
                
