@{
    InvokeBuild      = @{
        Name           = 'InvokeBuild'
        DependencyType = 'PSGalleryModule'
        Parameters     = @{
            Repository         = 'PSGallery'
            SkipPublisherCheck = $true
        }
        Target         = 'CurrentUser'
        Version        = '5.5.1'
        Tags           = 'Bootstrap'
    }

    Pester           = @{
        Name           = 'Pester'
        DependencyType = 'PSGalleryModule'
        Parameters     = @{
            Repository         = 'PSGallery'
            SkipPublisherCheck = $true
        }
        Target         = 'CurrentUser'
        Version        = '4.7.3'
        Tags           = 'Bootstrap'
    }

    PSScriptAnalyzer = @{
        Name           = 'PSScriptAnalyzer'
        DependencyType = 'PSGalleryModule'
        Parameters     = @{
            Repository         = 'PSGallery'
            SkipPublisherCheck = $true
        }
        Target         = 'CurrentUser'
        Version        = '1.18.0'
        Tags           = 'Bootstrap'
    }

    Platyps          = @{
        Name           = 'Platyps'
        DependencyType = 'PSGalleryModule'
        Parameters     = @{
            Repository         = 'PSGallery'
            SkipPublisherCheck = $true
        }
        Target         = 'CurrentUser'
        Version        = '0.14.0'
        Tags           = 'Bootstrap'
    }
}
