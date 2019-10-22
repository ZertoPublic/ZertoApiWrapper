<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoEvacuateVra {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "VraIdentifier")]
    param (
        # HostName Option
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the Host to Evacuate",
            ParameterSetName = "HostName"
        )]
        [String]$HostName,
        # VRA Option
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the VRA to Evacuate",
            ParameterSetName = "VraName"
        )]
        [String]$VraName,
        # VRAIdentifier Option
        [Parameter(
            Mandatory,
            HelpMessage, "Identifier of the VRA to be evacuated",
            ParameterSetName = "VraIdentifier",
            ValueFromPipelineByPropertyName,
            ValueFromPipeline
        )]
        [Alias("VraId", "Identifier")]
        [String]$VraIdentifier
    )

    begin {

    }

    process {
        switch ($PSCmdlet.ParameterSetName) {
            "HostName" {
                $VraName = "Z-VRA-" + $HostName
                Invoke-ZertoEvacuateVra -VraName $VraName
            }

            "VraName" {
                $VraIdentifier = (Get-ZertoVra -vraName $VraName).Identifier
                Invoke-ZertoEvacuateVra -VraIdentifier $VraIdentifier
            }

            "VraIdentifier" {
                $Uri = "vras/{0}/changerecoveryvra/execute" -f $VraIdentifier
                if ($PSCmdlet.ShouldProcess($VraIdentifier, "Evacuating VRA with Identifier:")) {
                    Invoke-ZertoRestRequest -Uri $Uri -Method "POST"
                }
            }
        }
    }

    end {

    }
}
