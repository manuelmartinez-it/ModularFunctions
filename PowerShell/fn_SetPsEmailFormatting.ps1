# Funtion to format an HTML message with a table
function Set-PsEmailFormatting {
    <#
        .SYNOPSIS
            Configure PowerShell to email a HTML formatted table
        .DESCRIPTION
            This will create and format a table to be emailed as an HTML message using only 
            PowerShell and providing basic information like SMTP, Sender, Recipient, Subject,
            Body Header and Table Content
        .EXAMPLE
            Set-PsEmailFormatting -SmtpServer smtp.domain.com -SenderEmail me@domain.com -RecipientEmail you@domain.com -EmailSubject 'Notifying you about something' -BodyHeader 'This is info I want to report to you' -TableInfo $Report
        .NOTES
            Created 09/20/2018 by Manuel Martinez, Version 1.0
            Github: https://www.github.com/manuelmartinez-it
    #>
    [CmdletBinding()]
    param (
        # SMTP server name
        [Parameter(
            Mandatory,
            HelpMessage = 'Name of the SMTP server to use'
        )]
        [String]
        $SmtpServer,

        # Sender email address
        [Parameter(
            Mandatory,
            HelpMessage = 'Email address of the Sender'
        )]
        [String]
        $SenderEmail,

        # Recipient email address
        [Parameter(
            Mandatory,
            HelpMessage = 'Email address of the Recipient'
        )]
        [String]
        $RecipientEmail,

        # Email Subject line
        [Parameter(
            Mandatory,
            HelpMessage = 'Email subject line'
        )]
        [String]
        $EmailSubject,

        # Email Header line
        [Parameter(
            Mandatory,
            HelpMessage = 'Header for table to report on'
        )]
        [String]
        $BodyHeader,

        # Information to report on
        [Parameter(
            Mandatory,
            HelpMessage = 'Variable with the infomation you want to report on',
            ValueFromPipeline = $true
            )]
        [$PSObject]
        $TableInfo
    )

# Format for table to be emailed out 
$head=@"
<style>
@charset "UTF-8";

table
{
font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
border-collapse:collapse;
}
td 
{
font-size:1em;
border:1px solid #98bf21;
padding:5px 5px 5px 5px;
}
th 
{
font-size:1.1em;
text-align:center;
padding-top:5px;
padding-bottom:5px;
padding-right:7px;
padding-left:7px;
background-color:#A7C942;
color:#ffffff;
}
name tr
{
color:#F00000;
background-color:#EAF2D3;
}
</style>
"@

    # Create, format and send HTML email
    $report = $TableInfo | ConvertTo-Html -Head $head -PreContent "<H2>$BodyHeader</H2>" | Out-String
    $msg = new-object Net.Mail.MailMessage
    $smtp = new-object Net.Mail.SmtpClient($SmtpServer)
    $msg.From = $SenderEmail
    $msg.To.Add($RecipientEmail)
    $msg.Subject = $EmailSubject
    $msg.IsBodyHTML = $true
    $msg.Body = $report
    $smtp.Send($msg)

}

