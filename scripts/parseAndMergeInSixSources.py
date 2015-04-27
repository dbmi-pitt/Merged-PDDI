import sys
import csv

INPUT_DDIS = "../../DIKB-multiple-sources/CombinedDatasetNotConservativeAllsources.csv"
INPUT_CLASS_MAPPING = "../data/drug-class-mapping.tsv"

OUTPUT_FILE = "../data/DIKB-6-sources.csv"

drugClassD = {}

with open (INPUT_CLASS_MAPPING,"rb") as classMapFile:
    csvReader = csv.reader(classMapFile, delimiter='\t')
    for row in csvReader:
        if row[2]:
            drugClassD[row[0]] = row[2]

#print drugClassD

with open(OUTPUT_FILE, 'wb') as outputf:
    writer = csv.writer(outputf)

    with open(INPUT_DDIS,"rb") as csvfile:
        csvReader = csv.reader(csvfile, delimiter='\t')
        header = next(csvReader)
        
        header.append("DrugClass1")
        header.append("DrugClass2")
        writer.writerow(header)
        for row in csvReader:

            if row[20] in ["Drugbank","DIKB","NDF-RT","ONC-HighPriority","ONC-NonInteruptive","CredibleMeds"]:

                if drugClassD.has_key(row[1].upper()):
                    row.append(drugClassD[row[1].upper()])
                else:
                    row.append("None")
                if drugClassD.has_key(row[3].upper()):
                    row.append(drugClassD[row[3].upper()])
                else:
                    row.append("None")
                writer.writerow(row)
                
