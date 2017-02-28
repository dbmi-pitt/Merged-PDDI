import csv

#generate insert sql file with given csv file
def main():

	with open('frenchDDI.csv','rb') as csvfile:
		target = open('insertFrench.sql', 'w')
		reader=csv.reader(csvfile, delimiter='\t', quotechar='|')
		#print reader.fieldnames
		output = 'INSERT INTO `interactions1` (`interactionID`, `drug1`, `object`, `drug1ID`, `drug2`, `precipitant`, `drug2ID`, `certainty`, `contraindication`, `dateAnnotated`, `ddiPkEffect`, `ddiPkMechanism`, `effectConcept`, `homepage`, `label`, `numericVal`, `pathway`, `precaution`, `severity`, `uri`, `whoAnnotated`, `source`, `ddiType`, `evidence`, `evidenceSource`, `evidenceStatement`, `researchStatementLabel`, `researchStatement`, `managementOptions`, `DrugClass1`, `DrugClass2`, `objectUri`, `precipUri`) VALUES\n'
		for row in reader:
			output += '("","",'+row[1]+','
			if row[7] == "":
				output += '"",'
			else:
				output += row[7]+','
			output += '"",'+row[0]+','
			if row[8] == "":
				output += '"",'
			else:
				output += row[8]+','
			output += '"","","","",'+row[5]+',"","",'+row[4]+',"","","",'+row[6]+',"","","French National Formulary (Fr.)","","","","","","","",'+row[3]+','+row[2]+',"",""),\n'
		
		output = output[:-2] + ';'
		target.write(output)
		print("Done")
		

if __name__ == '__main__':
	main()