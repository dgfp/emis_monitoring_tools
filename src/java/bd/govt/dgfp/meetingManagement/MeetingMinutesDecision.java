package bd.govt.dgfp.meetingManagement;

import java.util.ArrayList;
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
public class MeetingMinutesDecision {
    private String item;
    private ArrayList<String> decisionText;

    public MeetingMinutesDecision() {
    }

    public MeetingMinutesDecision(String item, ArrayList<String> decisionText) {
        this.item = item;
        this.decisionText = decisionText;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public ArrayList<String> getDecisionText() {
        return decisionText;
    }

    public void setDecisionText(ArrayList<String> decisionText) {
        this.decisionText = decisionText;
    }
}
