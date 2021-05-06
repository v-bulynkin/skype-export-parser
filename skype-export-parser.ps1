# source folder
$rootFolder = (read-host "Enter the Skype exported files folder path").trim() -replace "\\+$"
# Time offset (all messages in Skype export have UTC timestamps so they need to be converted)
$tz = Get-TimeZone
if ($tz.BaseUtcOffset.TotalMinutes -ne 0) {
    Write-Host -fore Magenta "Messages' timestamps will be recalculated to your timezone:`n$($tz.displayname)."
}
$mediaFolder = dir "$rootFolder\media"
# sort messages by time ascending
$messages = (gc "$rootFolder\messages.json" -Encoding UTF8 |ConvertFrom-Json).conversations.messagelist |sort id
$IDs = $messages.conversationid -match "^8:" |sort -Unique

foreach ($ID in $IDs) {
    # Exclude message service types, get timestamp string
    $thread = $messages |? {$_.conversationid -eq "$ID" -and $_.messagetype -match 'text'} |select *,
    @{n='timestamp';e={if ($tz.BaseUtcOffset.TotalMinutes -ne 0) {($_.originalarrivaltime -as [datetime]).addminutes($tz.BaseUtcOffset.TotalMinutes)} else {$_.originalarrivaltime -as [datetime]}}}

    $IDdisplayName = $thread.displayname |sort -Unique
    Write-Host -fore Green "Processing thread with $IDdisplayName..."

    mkdir "$rootFolder\$IDdisplayName" -ErrorAction SilentlyContinue > $null

    $threadHtml = ,"<title>$IDdisplayName</title>"
    $threadHtml += foreach ($msg in $thread) {
        # Is there media content and is it presented locally
        if ($msg.amsreferences -and $mediaFolder -match $msg.amsreferences) {
        $msgMediaJson,$msgMedia = ($mediaFolder -match $msg.amsreferences).where({$_.extension -eq '.json'}, 'split')
        # what extension the media file has
        $msgMediaExt = (gc "$($msgMediaJson.fullname)" |ConvertFrom-Json).filename -replace "^.*\."
        # select the biggest one
        $msgMediaFile = $msgMedia |sort length |select -last 1
        # copy (not rename because you may need to start this script again)
        copy "$($msgMediaFile.fullname)" "$rootFolder\media\$($msgMediaFile.basename).$msgMediaExt" -ErrorAction SilentlyContinue
        $msgMediaPath = "media\$($msgMediaFile.basename).$msgMediaExt"
            
        Copy-Item "$($msgMediaFile.fullname)" "$rootFolder\$IDdisplayName\$(($msg.timestamp).tostring("yyyy-MM-dd HH-mm-ss")) $IDdisplayName.$msgMediaExt" -ErrorAction SilentlyContinue
            
            # Image or video
            if ($msgMediaPath -match "jpe?g$|png$|gif$") {
            $msgContent = $msg.content -replace "<URIObject.*URIObject>","<img src=`"$msgMediaPath`" style=`"max-width:640px;width:100%`">"
            }
            else {
            $msgContent = $msg.content -replace "<URIObject.*URIObject>","<video controls style=`"max-width:640px;width:100%`"> <source src=`"$msgMediaPath`"  type=`"video/$msgMediaExt`" /></video>"
            }
        }
        # If no media
        else {
        $msgContent = $msg.content
        }
    
        # Highlight interlocutor posts (your displayname is not shown in conversations)
        if ($msg.displayname) {
        "<p style=`"background-color:#c9e4ff`"><i>$(($msg.timestamp).tostring()) $($msg.displayname)</i><br>$msgContent</p>"
        }
        else {
        "<p><i>$(($msg.timestamp).tostring())</i><br>$msgContent</p>"
        }
    }
            
    # Write the HTML down
    $threadHtml > "$rootFolder\$IDdisplayName.html"

}
