class PersonNotFoundException : System.Exception {

    $UsedID
    $FirstName
    $LastName

    PersonNotFoundException ( [string] $Message ) : base ( $Message ) {

    }

}

$myError = [PersonNotFoundException]::new('lemons')

