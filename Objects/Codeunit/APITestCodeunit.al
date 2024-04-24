codeunit 50100 APITestCodeunit
{
    trigger OnRun()
    begin
    end;

    procedure IsValidPhoneNumber(PhoneNumber: Text): Boolean
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JsonManagement: Codeunit "JSON Management";
        Response: Text;
        ResultVariant: Variant;
    begin
        GetAccessKey();
        if HttpClient.Get('https://apilayer.net/api/validate?access_key=' + AccessKeySetup."Access Key" + '&number=' + PhoneNumber + '&country_code=&format=1',
            HttpResponseMessage) then begin
            HttpResponseMessage.Content.ReadAs(Response);
            JsonManagement.InitializeObject(Response);
            JsonManagement.GetPropertyValueByName('valid', ResultVariant);
            exit(ResultVariant.IsBoolean());
        end else
            Message('Status Code : %1\Reason : %2', HttpResponseMessage.HttpStatusCode, HttpResponseMessage.ReasonPhrase);
    end;

    procedure GetCatFact(): Text
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        Url: Label 'https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=1';
        Response: Text;
        JsonManagement: Codeunit "JSON Management";
        ResultVariant: Variant;
    begin
        if HttpClient.Get(Url, HttpResponseMessage) then begin
            HttpResponseMessage.Content.ReadAs(Response);
            JsonManagement.InitializeObject(Response);
            JsonManagement.GetPropertyValueByName('text', ResultVariant);
            exit(Format(ResultVariant));
        end else
            Message('Status Code : %1\Reason : %2', HttpResponseMessage.HttpStatusCode, HttpResponseMessage.ReasonPhrase);
    end;

    local procedure GetAccessKey()
    begin
        if AccessKeySetup.IsEmpty() then
            AccessKeySetup.Get()
    end;

    var
        AccessKeySetup: Record "Access Key Setup";
}
