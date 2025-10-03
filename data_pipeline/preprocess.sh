#!/bin/bash
#variable for the input file, output file, log file, status column index and value to be excluded
INPUT="/home/jesuniyig/data_pipeline/input/sales_dataa.csv"
OUTPUT="/home/jesuniyig/data_pipeline/output/cleaned_sales_data.csv"
LOG="/home/jesuniyig/data_pipeline/logs/preprocess.log"
STATUS_COL_INDEX=6
EXCLUDE_VALUE="Failed"

#check if the input file exist
if [[ ! -f "$INPUT" ]]; then
	echo "Error: Input file '$INPUT' not found $(date +'%Y-%m-%d %H:%M:%S')." | tee -a "$LOG"
	exit 1
fi

#remove unwanted columns and rows from the records
awk -F',' -v status_col="$STATUS_COL_INDEX" -v exclude_val="$EXCLUDE_VALUE" '
BEGIN { OFS = "," }
NR == 1 {
	NF--
	print
	next
}
{
	if ($status_col != exclude_val) {
		NF--
		print
	}
}' "$INPUT" > "$OUTPUT" #save the cleaned records in the output csv file

# print a  completion message and log in the log file
echo "Cleaned records saved to '$OUTPUT'as at $(date +'%Y-%m-%d %H:%M:%S')." | tee -a "$LOG"
