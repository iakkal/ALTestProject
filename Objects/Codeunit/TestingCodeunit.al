codeunit 50101 "Testing Codeunit"
{
    Subtype = TestRunner;

    trigger OnBeforeTestRun(CodeunitId: Integer; CodeunitName: Text; FunctionName: Text; Permissions: TestPermissions): Boolean
    begin
    end;

    trigger OnAfterTestRun(CodeunitId: Integer; CodeunitName: Text; FunctionName: Text; Permissions: TestPermissions; Success: Boolean)
    begin
        if TestCatFact.GetCatFact.Value <> '' then
            Success := true;
    end;

    var
        TestCatFact: TestPage "Cat Fact";
}