/**
 * Created by gamedevmadeeasy on 10/29/19.
 */

public class EvidenceModel {
    private List<SearchModel> searchList {get; set;}
    public String id;
    public String choice_id;

    public EvidenceModel() {
        for(SearchModel search : searchList) {
            id = search.Id;
            if (search.Flag == true) {
                choice_id = 'present';
            }
        }
    }
}