table 50100 "Access Key Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Access Key Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Access Key"; Text[100])
        {
            Caption = 'Access Key';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}