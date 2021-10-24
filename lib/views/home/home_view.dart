import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '/controllers/view_controller.dart';

import '/constants.dart';
import '/responsive.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final ViewController _viewController = Get.find<ViewController>();

    final List<Color> gradientColors = [
      primaryColor,
      secondaryColor,
    ];

    _viewController.getSpots(0);
    _viewController.setRows(0);

    final List<String> imgList = [
    'assets/images/Creditos.png',
    'assets/images/Cuenta Ahorros.png',
    'assets/images/Cuenta Bancaria.png',
    'assets/images/Inversiones.png',
    'assets/images/Nomina.png',
    'assets/images/Pension.png',
    'assets/images/Seguro.png',
    'assets/images/Tarjeta de credito.png',
    'assets/images/Tarjeta de Debito.png',
  ];
    
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.asset(item, fit: BoxFit.cover, width: 1000.0)),
        ))
        .toList();

    final List dropdownItemList = [
      {'label': 'Tarjeta de credito', 'value': 0},
      {'label': 'Tarjeta de débito' , 'value': 1},
      {'label': 'Credito'           , 'value': 2},
      {'label': 'Cuenta bancaria'   , 'value': 3},
      {'label': 'Nómina'            , 'value': 4},
      {'label': 'Pensión'           , 'value': 5},
      {'label': 'Cuenta de ahorro'  , 'value': 6},
      {'label': 'Seguro'            , 'value': 7},
      {'label': 'Invertir'          , 'value': 8},
    ];

    List<Widget> _charts = [
      Expanded(
        flex: Responsive.isDesktop(context) ? 3 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Stack(
            children: [
              Obx(() => LineChart(
                LineChartData(
                minX: 0,
                maxX: 23,
                minY: 0,
                maxY: _viewController.chartIndex == 2 || _viewController.chartIndex == 4 || _viewController.chartIndex == 5 || _viewController.chartIndex == 8
                  ? 50 : _viewController.chartIndex == 7 ? 220 : 25,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.white,
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      bottom: BorderSide(
                          color: secondaryColor,
                          width: 1.0,
                          style: BorderStyle.solid),
                      left: BorderSide(
                          color: secondaryColor,
                          width: 1.0,
                          style: BorderStyle.solid)),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: SideTitles(showTitles: false),
                  rightTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  )
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: _viewController.spotsList.value,
                    isCurved: true,
                    barWidth: 5,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                        gradientFrom: const Offset(0.0, 1.0),
                        gradientTo: const Offset(0.0, 0.0),
                        show: true,
                        colors: gradientColors
                            .map((color) => color.withOpacity(0.4))
                            .toList(),
                    ))
                  ]
                )
              )),
              Positioned(
                right: 100,
                child: CoolDropdown(
                  defaultValue: dropdownItemList[0],
                  dropdownList: dropdownItemList, 
                  onChange: (value) {
                    _viewController.getSpots(value['value']);
                    _viewController.setRows(value['value']);
                  },
                  isTriangle: false,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10)
          ),
        )
      ),
      const SizedBox(
        width: defaultPadding * 2,
        height: defaultPadding * 2,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: !Responsive.isDesktop(context) ? _size.width : null,
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
            child: Obx(() => DataTable(
              dataRowHeight: 20,
              columnSpacing: 10,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Contenido'
                  )
                ),
                DataColumn(
                  label: Text(
                    'Ubicación'
                  )
                ),
                DataColumn(
                  label: Text(
                    'Servicio'
                  )
                ),
              ],
              rows: _viewController.rows.value,
            ),)
          ),
        ),
      ),
    ];

    List<Map<String, dynamic>> navbar = [
      {
        'title': 'Inicio',
        'length': 50 
      }, 
      {
        'title': 'Descripcion',
        'length': 105 
      }, 
      {
        'title': 'Resultados',
        'length': 95 
      }, 
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* SizedBox(
          width: _size.width,
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap:() => _viewController.homeIndex.value = index,
                child: Obx(() => Column(
                  children: [
                    Text(
                      navbar[index]['title'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: _viewController.homeIndex.value == index 
                          ? primaryColor 
                          : const Color.fromRGBO(4, 50, 99, 0.4)
                      ),
                    ),
                    if (_viewController.homeIndex.value == index)
                    Image.asset(
                      'assets/gif/line_icon.gif',
                      width: navbar[index]['length'],
                      height: 7,
                      fit: BoxFit.fill,
                    ),
                  ],
                )),
              );
            }, 
            separatorBuilder: (context, index) {
              return const SizedBox(width: defaultPadding * 2,);
            }, 
            itemCount: navbar.length
          ),
        ), */
        const SizedBox(height: defaultPadding * 2,),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 4),
                  margin: const EdgeInsets.only(bottom: defaultPadding * 4),
                  height: Responsive.isDesktop(context) ? _size.height * 0.50 : _size.height * 0.70,
                  child: Responsive(
                    desktop: Row(
                      children: _charts,
                    ),
                    tablet: Column(
                      children: _charts,
                    ),
                    mobile: Column(
                      children: _charts,
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 4),
                  child: SizedBox(
                    width: Responsive.isDesktop(context) ? _size.width * 0.70 : _size.height,
                    child: const Text(
                      'La gráfica anterior nos permite obtener una mejor visualización de los datos recopilados mediante las API\'s de AWS, y cómo estos se relacionan con los servicios ofrecidos por BBVA, abriendo paso a nuevas soluciones y opciones disponibles para generar un mayor interés en los posibles clientes, permitiendo así tener una mayor preferencia por parte de los mismos gracias a los beneficios que se les presentan.',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: primaryColor,
                        height: 1.5
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding * 4,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding * 4),
                  child: Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: primaryColor
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding * 2,),
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 4),
                          child: SizedBox(
                            width: Responsive.isDesktop(context) ? _size.width * 0.5 : _size.width,
                            child:  RichText(
                              text: const TextSpan(
                                text:'Haciendo uso de la API snscrape, obtuvimos un registro histórico de los tweets del día 22 de octubre de 2021. Estos se encuentran divididos en 9 categorías:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: bodyColor,
                                  fontSize: 18.0,
                                  height: 1.5
                                ),
                                children: [
                                  TextSpan(
                                    text: '''\n 
  - Tarjeta de crédito
  - Tarjeta de débito
  - Créditos
  - Cuentas bancarias
  - Nómina
  - Pensión
  - Cuentas de ahorro
  - Seguros
  - Inversión
''',
                                    style: TextStyle(
                                      color: primaryColor,
                                    )
                                  ),
                                  TextSpan(
                                    text: '\nCada uno de los tweets está relacionado a alguna de estas categorías'
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding* 2,),
                        Container(
                          color: const Color(0xFF064783),
                          width: _size.width,
                          height: _size.height,   
                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: _size.width * 0.35,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/Pension.png',
                                      width: 450,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    const Text(
                                      'Satisfacción de los usuarios con respecto a las pensiones ofrecidas por diferentes instituciones',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryColor,
                                        height: 1.5
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: _size.width * 0.50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const <Widget>[
                                    Text(
                                      'Solución',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: defaultPadding * 2,),
                                    Text(
                                      'Scraping de tweets',
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: defaultPadding * 2,),
                                    Text(
                                      'Nuestro primer objetivo fue recopilar una cantidad de tweets en base diferentes etiquetas predefinidas, estas fueron obtenidas a partir de los productos ofrecidos por BBVA.\nUna vez definidas estas etiquetas pudimos obtener una gran cantidad de Tweets. El fin de estos en analizar el nivel de satisfacción de las personas respecto a las etiquetas.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/hackaton.png',
                        width: 670,
                        fit: BoxFit.fitWidth,
                      )
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding*2, vertical: defaultPadding *2),
                  height: _size.height,
                  width: _size.width,
                  color: const Color(0xFF162B3E),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: _size.width * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Amazon Web Services',
                              style: TextStyle(
                                color: Color(0xFFFE9900),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: defaultPadding*2,),
                            Text(
                              'Debido a la barrera del idioma, nos surgió la necesidad de usar el servicio de AWS Translate; gracias a este pudimos obtener una traducción rápida y eficaz de los datos recolectados.\n\nPor otro lado, el servicio de AWS Comprehend nos permitió realizar el procesamiento más importante a nuestros datos, el análisis de sentimiento de las diferentes etiquetas, dando paso a la interpretación de los datos y la creación de las soluciones propuestas para satisfacer las necesidades ed BBVA presentadas en este reto.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400
                              ),
                              textDirection: TextDirection.ltr,
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/aws.jpg'
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding*2, vertical: defaultPadding *2),
                  height: _size.height,
                  width: _size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: _size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Visualización de Sentimientos relacionados a los Servicios',
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: defaultPadding*2,),
                            Text(
                              'Las siguientes gráficas nos muestran la tendencia emocional de los usuarios respecto a los servicios ofrecidos por diferentes instituciones.',
                              style: TextStyle(
                                color: bodyColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400
                              ),
                              textDirection: TextDirection.ltr,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: _size.width * 0.5,
                        height: _size.height * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            initialPage: 2,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3)
                          ),
                          items: imageSliders
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}