/*
    Example of Salesforce Security Setting(SFSecSettingService).
 */

public class SFSecSettingServiceExamples
{
    // Setup/Security/CORS Whitelisted Origins
    public static void handleCorsWhitelistOrigin()
    {
        gctsfdev.SFSecSettingService.AccessPort service = gctsfdev.SFSecSettingService.createService();

        // create
        gctsfdev.SFSecSettingService.CorsWhitelistOrigin md = new gctsfdev.SFSecSettingService.CorsWhitelistOrigin();
        md.fullName = 'developerName1';
        md.urlPattern = 'https://www.example.com';
        gctsfdev.SFSecSettingService.SaveResult[] sResults = service.createSecSetting(
            new gctsfdev.SFSecSettingService.Metadata[]{ md });
        for(gctsfdev.SFSecSettingService.SaveResult result : sResults) handleCrudResults(result);

        // read
        md = (gctsfdev.SFSecSettingService.CorsWhitelistOrigin) service.readSecSetting(
            'CorsWhitelistOrigin', new String[] { md.fullName }).getRecords()[0];
        System.debug('create: ' + md);
        System.assertEquals('https://www.example.com', md.urlPattern);

        // update
        md.urlPattern = 'https://*.example.com';
        gctsfdev.SFSecSettingService.UpsertResult[] uResults = service.upsertSecSetting(
            new gctsfdev.SFSecSettingService.Metadata[]{ md });
        for(gctsfdev.SFSecSettingService.UpsertResult result : uResults) handleCrudResults(result);

        // read
        md = (gctsfdev.SFSecSettingService.CorsWhitelistOrigin) service.readSecSetting(
            'CorsWhitelistOrigin', new String[] { md.fullName }).getRecords()[0];
        System.debug('upsert: ' + md);
        System.assertEquals('https://*.example.com', md.urlPattern);

        // delete
        gctsfdev.SFSecSettingService.DeleteResult[] dResults = service.deleteSecSetting(
            'CorsWhitelistOrigin', new String[] { md.fullName });
        for(gctsfdev.SFSecSettingService.DeleteResult result : dResults) handleCrudResults(result);

        // read
        md = (gctsfdev.SFSecSettingService.CorsWhitelistOrigin) service.readSecSetting(
            'CorsWhitelistOrigin', new String[] { md.fullName }).getRecords()[0];
        System.debug('delete: ' + md);
        System.assertEquals(null, md.fullName);
    }

    // Setup/Security/Named Credentials
    public static void handleNamedCredential()
    {
        gctsfdev.SFSecSettingService.AccessPort service = gctsfdev.SFSecSettingService.createService();

        // create
        gctsfdev.SFSecSettingService.NamedCredential md = new gctsfdev.SFSecSettingService.NamedCredential();
        md.fullName = 'developerName1';
        md.label = 'example1';
        md.endpoint = 'https://www.example.com/api';
        md.principalType = 'NamedUser';
        md.protocol = 'Password';
        md.username = 'username';
        md.password = 'password';
        md.generateAuthorizationHeader = true;
        md.allowMergeFieldsInBody = false;
        md.allowMergeFieldsInHeader = false;
        gctsfdev.SFSecSettingService.SaveResult[] sResults = service.createSecSetting(
            new gctsfdev.SFSecSettingService.Metadata[]{ md });
        for(gctsfdev.SFSecSettingService.SaveResult result : sResults) handleCrudResults(result);

        // read
        md = (gctsfdev.SFSecSettingService.NamedCredential) service.readSecSetting(
            'NamedCredential', new String[] { md.fullName }).getRecords()[0];
        System.debug('create: ' + md);
        System.assertEquals('https://www.example.com/api', md.endpoint);

        // update
        md.endpoint = 'https://example.com/api2';
        gctsfdev.SFSecSettingService.UpsertResult[] uResults = service.upsertSecSetting(
            new gctsfdev.SFSecSettingService.Metadata[]{ md });
        for(gctsfdev.SFSecSettingService.UpsertResult result : uResults) handleCrudResults(result);

        // read
        md = (gctsfdev.SFSecSettingService.NamedCredential) service.readSecSetting(
            'NamedCredential', new String[] { md.fullName }).getRecords()[0];
        System.debug('upsert: ' + md);
        System.assertEquals('https://example.com/api2', md.endpoint);

        // delete
        gctsfdev.SFSecSettingService.DeleteResult[] dResults = service.deleteSecSetting(
            'NamedCredential', new String[] { md.fullName });
        for(gctsfdev.SFSecSettingService.DeleteResult result : dResults) handleCrudResults(result);

        // read
        md = (gctsfdev.SFSecSettingService.NamedCredential) service.readSecSetting(
            'NamedCredential', new String[] { md.fullName }).getRecords()[0];
        System.debug('delete: ' + md);
        System.assertEquals(null, md.fullName);
    }

    /**
     * helper method to interpret a SaveResult, UpsertResult or DeleteResult throws an exception if errors are found
     **/
    public static void handleCrudResults(gctsfdev.SFSecSettingService.ICrudResult crudResult)
    {
        // success
        if(crudResult==null || crudResult.getSuccess()) return;
        System.debug(crudResult);
        // has error message and throw an exception
        if(crudResult.getErrors()!=null) {
            List<String> messages = new List<String>();
            messages.add('The error occured processing component ' + crudResult.getFullName() + '.');
            for(gctsfdev.SFSecSettingService.Error error : crudResult.getErrors()) {
                messages.add(error.message + ' (' + error.statusCode + ').');
            }
            throw new gctsfdev.SFSecSettingService.SFSecSettingException(String.join(messages, '\n'));
        }
        if(!crudResult.getSuccess()) {
            throw new gctsfdev.SFSecSettingService.SFSecSettingException('Request failed with no specified error.');
        }
    }

}