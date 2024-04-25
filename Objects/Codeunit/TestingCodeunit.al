codeunit 50101 "Testing Codeunit"
{
    Subtype = Test;

    trigger OnRun()
    begin
        TestCatFact.OpenView();
        if TestCatFact.GetCatFact.Value = '' then
            Error('');
    end;

    var
        TestCatFact: TestPage "Cat Fact";
}