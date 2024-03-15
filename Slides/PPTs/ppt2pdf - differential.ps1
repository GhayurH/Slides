# If PowerShell exits with an error, check if unsigned scripts are allowed in your system.
# You can allow them by calling PowerShell as an Administrator and typing
# ```
# Set-ExecutionPolicy Unrestricted
# ```

# Batch convert all .ppt/.pptx files encountered in folder and all its subfolders
# The produced PDF files are stored in the invocation folder
#
# Get invocation path
$curr_path = Split-Path -parent $MyInvocation.MyCommand.Path

# Path to store information about last run
$last_run_file = Join-Path $curr_path "last_run.txt"

# Get the timestamp of the last run
$last_run_timestamp = Get-Content $last_run_file -ErrorAction SilentlyContinue

# Create a PowerPoint object
$ppt_app = New-Object -ComObject PowerPoint.Application

# Get all objects of type .ppt? in $curr_path and its subfolders that have been modified since the last run
Get-ChildItem -Path $curr_path -Recurse -Filter *.ppt? | Where-Object { $_.LastWriteTime -gt $last_run_timestamp } | ForEach-Object {
    Write-Host "Processing" $_.FullName "..."
    # Open it in PowerPoint
    $document = $ppt_app.Presentations.Open($_.FullName)
    # Create a name for the PDF document
    $pdf_filename = Join-Path $curr_path "$($_.BaseName).pdf"
    # Save as PDF
    $opt = [Microsoft.Office.Interop.PowerPoint.PpSaveAsFileType]::ppSaveAsPDF
    $document.SaveAs($pdf_filename, $opt)
    # Close PowerPoint file
    $document.Close()
}

# Update the last run timestamp
(Get-Date).ToString() | Set-Content $last_run_file

# Exit and release the PowerPoint object
$ppt_app.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ppt_app)

# Move files to PDF folder if needed
Move-Item *.pdf ../PDFs/ -Force