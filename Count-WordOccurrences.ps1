# Pull the contents of the text file
$Content = (Invoke-WebRequest "http://classics.mit.edu/Homer/odyssey.mb.txt").RawContent

# Convert to a string and split the lines
$File = ($Content | Out-String).Split()

# Split at each punctuation mark
@(".","?","!",",",";",":","-","{","}",")","(","[","]","`"","...") | Foreach-Object {
    $File = $File.Split($_)
}

# Generated our counts and sort
$WordCounts = $File | Group-Object | Select-Object Name,Count | Sort-Object Count -Descending

# Export to a CSV for viewing or manipulation
$WordCounts | Export-Csv -Path OdysseyWordCounts.csv -NoTypeInformation