import 'package:project_vofaze/model/ticket_model.dart';
import 'package:project_vofaze/services/ticket_service.dart';
import 'package:provider/provider.dart';

final ticketServiceProvider = ChangeNotifierProvider<TicketService>(
  create: (context) => TicketService(), 
);
// class TicketServiceProvider extends ChangeNotifier {
//   TicketService _ticketService = TicketService();

//   TicketService get ticketService => _ticketService;

//   void newTicketService(TicketModel ticketModel) async {
//     try {
//       _ticketService.addTicket(ticketModel);
//       notifyListeners();
//       print("Ticket salvo com sucesso no Firebase!");
//     } catch (e) {
//       print("Erro ao salvar o ticket: $e");
//     }
//   }
// }
