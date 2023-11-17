import 'package:chat_assessment/service/navigation_service.dart';
import 'package:chat_assessment/service/routing_service.dart';
import 'package:chat_assessment/service/service_locator.dart';
import 'package:stacked/stacked.dart';

class UserViewModel extends BaseViewModel {

  goToChat() {
    locator<NavigationService>().navigateToAndBack(chatView);
  }
}