pageextension 50101 "Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addbefore(Control149)
        {
            part(CatFact; "Cat Fact")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Contact)
        {
            action("Validate Phone")
            {
                Caption = 'Validate Phone';
                ApplicationArea = all;

                trigger OnAction()
                var
                    NewTestCodeunit: Codeunit APITestCodeunit;
                begin
                    if NewTestCodeunit.IsValidPhoneNumber(Rec."Phone No.") then
                        Message('Phone Number is Valid!')
                    else
                        Message('Phone Number is Invalid');
                end;
            }
        }
    }
}