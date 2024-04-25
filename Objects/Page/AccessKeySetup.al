page 50100 "Access Key Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Access Key Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Access Key"; AccessKey)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IsolatedStorage.Set(Rec."Primary Key", AccessKey, DataScope::Module);
                        Rec.Validate("Access Key", AccessKey);
                        Rec.Modify();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        IsolatedStorage.Set(Rec."Primary Key", Rec."Access Key");
        IsolatedStorage.SetEncrypted(Rec."Primary Key", Rec."Access Key");
        IsolatedStorage.Get(Rec."Primary Key", AccessKey);
    end;

    var
        AccessKey: Text;
}