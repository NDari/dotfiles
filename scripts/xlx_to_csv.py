import xlrd
import csv
import sys

inp = sys.argv[1]
sht = sys.argv[2]
out = sys.argv[3]

wb = xlrd.open_workbook(inp)
sh = wb.sheet_by_name(sht)
your_csv_file = open(out, 'w')
wr = csv.writer(your_csv_file, quoting=csv.QUOTE_ALL)

for rownum in range(sh.nrows):
    wr.writerow(sh.row_values(rownum))

your_csv_file.close()
