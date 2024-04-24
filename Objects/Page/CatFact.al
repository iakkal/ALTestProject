page 50102 "Cat Fact"
{
    Caption = 'Cat Fact';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;

    layout
    {
        area(content)
        {
            field(GetCatFact; NewTestCodeunit.GetCatFact())
            {
                Caption = 'Cat Fact';
                ApplicationArea = All;
            }
        }
    }

    var
        NewTestCodeunit: Codeunit APITestCodeunit;
}