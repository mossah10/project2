/**
 * Created by gamedevmadeeasy on 10/29/19.
 */

public class SearchResults {

    private SearchAPI apiCaller = new SearchAPI();
    public Boolean moreSymptoms {get; set;}
    public Boolean active {get; set;}
    public String Phrase {get; set;}
    public List<SearchModel> wrapClassList { get; set; }
    public SearchModel wc { get; set; }
    public List<SearchModel> selectedSearchResults {get; set;}

    /**
    * Sets default values for items that will be utilized on the page.
    */
    public SearchResults(){
        moreSymptoms = false;
        active = false;
        Phrase = '';
        wrapClassList = new List<SearchModel>();
    }

    /**
    * Checks whether the user needs to add more symptoms to the list or not.
    * @return whether the user has more symptoms to add or not.
    */
    public PageReference moreSymptomSelection() {
        selectedSearchResults = new List<SearchModel>();
        for(SearchModel searchObjects : wrapClassList) {
            if (searchObjects.Flag == true) {

            }
            else {

            }
        }
        return null;
    }

    /**
    * Saves the selection of checkboxes that have been set to true.
    */
    public void saveSelected() {
        selectedSearchResults = new List<SearchModel>();
        for(SearchModel searchObjects : wrapClassList) {
            if(searchObjects.Flag == true) {
                wc = new SearchModel();
                wc.Id = searchObjects.Id;
                wc.Label = searchObjects.Label;
                selectedSearchResults.add(wc);
            }
        }
    }

    /**
    * Sends the results of the http response and adds it to a list.
    * @return to the same page with more data to be shown.
    */
    public PageReference onSend(){
        wrapClassList = apiCaller.getHttpResponseData(wc, wrapClassList, Phrase);
        active = true;
        return null;
    }
}