import 'package:bloc/bloc.dart';
import 'package:AP/src/pages/DetailProduct.dart';
import 'package:AP/src/pages/HomePage.dart';
import 'package:AP/src/pages/MateriasPage.dart';
import 'package:AP/src/pages/MyAccountPage.dart';
import 'package:AP/src/pages/MyOrder.dart';
import 'package:AP/components/preguntas/PreguntasPage.dart';

enum NavigationEvents {
  HomePageClickEvent,
  MateriasPageClickEvent,
  PreguntasPageClickEvent,
  DetailProductPageClickEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
}
int idProducto;
void cargarProducto(idProductoLoad) {
  idProducto = idProductoLoad;
}

int idMateria;
String nombreMateria;
void cargarIdMateriasAndNombreMateria(idMateriaData, nombreMateriaData) {
  idMateria = idMateriaData;
  nombreMateria = nombreMateriaData;
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc();
  @override
  NavigationStates get initialState => MateriasPage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.PreguntasPageClickEvent:
        yield PreguntasPage(
          idMateria: idMateria,
          nombreMateria: nombreMateria,
        );
        break;
      case NavigationEvents.MateriasPageClickEvent:
        yield MateriasPage();
        break;
      case NavigationEvents.HomePageClickEvent:
        yield HomePage();
        break;
      case NavigationEvents.DetailProductPageClickEvent:
        yield DetailProduct(
          idProducto: idProducto,
        );
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountPage();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrder();
        break;
    }
  }
}
