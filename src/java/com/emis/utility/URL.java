package com.emis.utility;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Helal
 */
public class URL {

    public final static String mis1 = "mis-form-1";
    public final static String mis1_dgfp = "mis-form-1-test";

    public final static String mis2 = "MIS_2";
    public final static String mis2_dgfp = "MIS_2_DGFP";

    public final static String mis4 = "MIS_4";
    public final static String mis4_dgfp = "MIS_4_DGFP";

    public final static String mis1_approval_manager = "ReportSubmission";
    public final static String mis1_approval_manager_dgfp = "ReportSubmissionTest";

    public final static String mis2_approval_manager = "MIS2ApprovalProcess";
    public final static String mis2_approval_manager_dgfp = "MIS2ApprovalProcessDGFP";

    public final static String mis4_approval_manager = "mis4-approval-manager";
    public final static String mis4_approval_manager_dgfp = "mis4-approval-manager-dgfp";

    public final static String mis1_approval_status = "mis1-approval-status";
    public final static String mis1_approval_status_dgfp = "mis1-approval-status-test";

    public final static String mis2_approval_status = "mis2-approval-status";
    public final static String mis2_approval_status_dgfp = "mis2-approval-status-9v-all";

    public final static String mis4_approval_status = "mis4-approval-status";
    public final static String mis4_approval_status_dgfp = "mis4-approval-status-9v-all";

    public final static String eligible_couple = "elco_details";
    public final static String eligible_couple_dgfp = "eligible-couple";

    public final static String elco_by_acceptor_status = "ElcoCountChildAndAgeWise";
    public final static String elco_by_acceptor_status_dgfp = "elco-by-acceptor-status";

    public final static String mobile_phone_coverage = "mobile-phone-coverage-hh";
    public final static String mobile_phone_coverage_dgfp = "mobile-phone-coverage";

    public final static String nid_coverage = "NidPossessionStatus";
    public final static String nid_coverage_dgfp = "nid-coverage";

    public final static String brn_coverage = "BRidPossessionStatusUpdated";
    public final static String brn_coverage_dgfp = "brn-coverage";

    public final static String household_wise_population = "populationCountKhanaWise";
    public final static String household_wise_population_dgfp = "household-wise-population";

    public final static String villlage_wise_population = "yearlyPopulationCountVillageWise";
    public final static String villlage_wise_population_dgfp = "villlage-wise-population";
    
    public final static String pregnant_woman_registration_status = "pregnant";
    public final static String pregnant_woman_registration_status_dgfp = "pregnant-woman-dgfp";
    
    public final static String birth_notification = "birth";
    public final static String birth_notification_dgfp = "birth-notification";
    
    public final static String death_notification = "death";
    public final static String death_notification_dgfp = "death-notification";

    protected List<String> url = new ArrayList<>();
    protected List<String> url_dgfp = new ArrayList<>();

    public URL() {
        url.add(mis1);
        url_dgfp.add(mis1_dgfp);

        url.add(mis2);
        url_dgfp.add(mis2_dgfp);

        url.add(mis4);
        url_dgfp.add(mis4_dgfp);

        url.add(mis1_approval_manager);
        url_dgfp.add(mis1_approval_manager_dgfp);

        url.add(mis2_approval_manager);
        url_dgfp.add(mis2_approval_manager_dgfp);

        url.add(mis4_approval_manager);
        url_dgfp.add(mis4_approval_manager_dgfp);

        url.add(mis1_approval_status);
        url_dgfp.add(mis1_approval_status_dgfp);

        url.add(mis2_approval_status);
        url_dgfp.add(mis2_approval_status_dgfp);

        url.add(mis4_approval_status);
        url_dgfp.add(mis4_approval_status_dgfp);

        url.add(eligible_couple);
        url_dgfp.add(eligible_couple_dgfp);

        url.add(elco_by_acceptor_status);
        url_dgfp.add(elco_by_acceptor_status_dgfp);

        url.add(mobile_phone_coverage);
        url_dgfp.add(mobile_phone_coverage_dgfp);

        url.add(nid_coverage);
        url_dgfp.add(nid_coverage_dgfp);

        url.add(brn_coverage);
        url_dgfp.add(brn_coverage_dgfp);
        
        url.add(household_wise_population);
        url_dgfp.add(household_wise_population_dgfp);
        
        url.add(villlage_wise_population);
        url_dgfp.add(villlage_wise_population_dgfp);
        
        url.add(pregnant_woman_registration_status);
        url_dgfp.add(pregnant_woman_registration_status_dgfp);
        
        url.add(birth_notification);
        url_dgfp.add(birth_notification_dgfp);
        
        url.add(death_notification);
        url_dgfp.add(death_notification_dgfp);
    }
}
