class ApiClient {
  String api_token = '';
  //static String baseUrl = 'https://pvawg.brac.net/';
  //static String baseUrl = 'http://nanoit.biz/project/ei/';
  //static String baseUrl = 'https://unhcrapi.la360host.com/api/';
  //static String baseUrl = 'https://unhcrapi.la360host.com/api/';
  static String baseUrl = 'https://unhcrtestapi.la360host.com/api/';
  //static String login = '${baseUrl}api/login';
  static String login = '${baseUrl}login';
  //static String drug_list = '${baseUrl}drug/list';
  static String drug_list = '${baseUrl}dispatch/item_list';
  static String current_stock_list = '${baseUrl}currentstock/medicineList';
  static String stock_receive_list = '${baseUrl}stockout/facility_stockout_data/distribution_approved';
  static String dispensary_received = '${baseUrl}stockout/facility_stockout_data/dispensary_received';
  static String stock_receive_medicine_list = '${baseUrl}stockin/dispensary_medicine_list';
  static String stock_receive_medicine_list_view = '${baseUrl}stockin/dispensary_received_details';
  static String submit_dispatch = '${baseUrl}dispatch/savedata';
  static String submit_tally = '${baseUrl}dispatch/saveitems';
  static String submit_internal_request = '${baseUrl}dispensary/internal/request/savedata';
  static String submit_stock_receive = '${baseUrl}stockin/dispensary_stockin';
}
