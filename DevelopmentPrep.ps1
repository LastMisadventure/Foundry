$script:Scoped_ModuleConfig = Import-PowerShellDataFile -Path .\Foundry\Config.psd1

# Create a Self-signed Code-signing cert:

# $splat = @{

#     CertStoreLocation = "cert:\currentuser\my"
#     Subject           = "CN=Test Code Signing"
#     KeyAlgorithm      = 'RSA'
#     KeyLength         = 2048
#     Provider          = "Microsoft Enhanced RSA and AES Cryptographic Provider"
#     KeyExportPolicy   = 'Exportable'
#     KeyUsage          = 'DigitalSignature'
#     Type              = 'CodeSigningCert'


# }

# New-SelfSignedCertificate @splat
