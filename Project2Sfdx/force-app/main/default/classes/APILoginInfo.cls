/**
 * Created by gamedevmadeeasy on 10/30/19.
 */

public class APILoginInfo {
    /**
     * Locates the API Key for Infermedica that resides in a Static Resource
     * @return the API Key as a String value.
     */
    public static String APIKey()  {
        StaticResource KeyResource = [
                SELECT Body
                FROM StaticResource
                WHERE Name = 'InfermedicaKey'
                LIMIT 1
        ];
        return KeyResource.Body.toString();
    }

    /**
    * Locates the API ID for Infermedica that resides in a Static Resource
    * @return the API ID as a String value.
 */
    public static String APIID() {
        StaticResource IDResource = [
                SELECT Body
                FROM StaticResource
                WHERE Name = 'InfermedicaId'
                LIMIT 1
        ];
        return IDResource.Body.toString();
    }
}