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
        AccessKey: Label '77877c1abe1af7dc0b57e0d474cdbb5d';
    begin
        if HttpClient.Get('https://apilayer.net/api/validate?access_key=' + AccessKey + '&number=' + PhoneNumber + '&country_code=&format=1',
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
}
