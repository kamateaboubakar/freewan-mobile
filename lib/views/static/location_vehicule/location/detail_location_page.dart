import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/tools/widgets/date_time_range_editing_controller.dart';
import 'package:wan_mobile/views/controllers/location_vehicule/detail_location_page_vctl.dart';

class DetailLocationVehiculePage extends StatelessWidget {
  final Car vehicule;
  const DetailLocationVehiculePage(this.vehicule, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailLocationVehiculePageVctl>(
        init: DetailLocationVehiculePageVctl(vehicule),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Détails de la location'),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: CButton(
                height: 50,
                onPressed: ctl.checkDate,
                child: const Text("Continuer"),
              ),
            ),
            body: SingleChildScrollView(
              controller: ctl.scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Visibility(
                    visible: vehicule.options.isNotEmpty &&
                        vehicule.options.first.withDriver == 1,
                    child: SwitchListTile(
                      value: ctl.withDriver,
                      onChanged: (value) {
                        ctl.withDriver = value;
                        ctl.update();
                      },
                      contentPadding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AssetColors.grey8),
                      ),
                      title: const Text("Avec chauffeur"),
                      subtitle: const Text(
                        "Vous n’avez pas de chauffeur? Louez la"
                        " voiture avec un chauffeur et un rabais",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const Gap(20),
                  const ListTile(
                    title: Text("Veuillez sélectionner les dates de location,"
                        " puis d'assigner des heures à ces dates."),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromRGBO(181, 196, 216, 1),
                      ),
                    ),
                    child: TableCalendar(
                      sixWeekMonthsEnforced: true,
                      calendarStyle: const CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AssetColors.blueButton,
                        ),
                      ),
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: ctl.focusedDay ?? DateTime.now(),
                      selectedDayPredicate: (day) {
                        if (ctl.seletedDays.isEmpty) {
                          return false;
                        } else {
                          return ctl.seletedDays
                              .where((e) => e.start.date.isSameDate(day))
                              .isNotEmpty;
                        }
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        var date = ctl.seletedDays.firstWhereOrNull(
                            (e) => e.start.date.isSameDate(selectedDay));
                        if (date == null) {
                          ctl.seletedDays.add(
                            CustomDateTimeRange(
                                startDate: selectedDay, endDate: selectedDay),
                          );
                        }
                        ctl.seletedDays.sort(
                            (a, b) => a.start.date!.compareTo(b.start.date!));
                        ctl.focusedDay = focusedDay;
                        ctl.update();
                      },
                    ),
                  ),
                  Visibility(
                    visible: ctl.seletedDays.isNotEmpty,
                    child: Column(
                      children: [
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Tooltip(
                              message: "Supprimer toutes les dates",
                              child: OutlinedButton.icon(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                    AssetColors.blueButton,
                                  ),
                                ),
                                icon: const Icon(Icons.delete),
                                onPressed: (ctl.seletedDays.isEmpty)
                                    ? null
                                    : () {
                                        ctl.seletedDays.clear();
                                        ctl.update();
                                      },
                                label: const Text("Vider"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Column(
                    children: ctl.seletedDays
                        .map(
                          (e) => Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                          "Jour du ${e.start.date.toFrenchDate}"),
                                      subtitle: Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CTextFormField(
                                                readOnly: true,
                                                controller:
                                                    e.start.textController,
                                                labelText: "Heure de début",
                                                onTap: () async {
                                                  var time =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime: e
                                                        .start.date.toTimeOfDay,
                                                  );
                                                  if (time != null) {
                                                    e.start.setTime = e
                                                        .start.date
                                                        .setTimeOfDay(time);
                                                    ctl.update();
                                                  }
                                                },
                                              ),
                                            ),
                                            const Gap(10),
                                            Expanded(
                                              child: CTextFormField(
                                                readOnly: true,
                                                controller:
                                                    e.end.textController,
                                                labelText: "Heure de fin",
                                                onTap: () async {
                                                  var time =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        e.end.date.toTimeOfDay,
                                                  );
                                                  if (time != null) {
                                                    e.end.setTime = e.end.date!
                                                        .setTimeOfDay(time);
                                                    ctl.update();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    color: AssetColors.blueButton,
                                    onPressed: () {
                                      ctl.seletedDays.remove(e);
                                      ctl.update();
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  Visibility(
                    visible: ctl.seletedDays.isNotEmpty,
                    child: Column(
                      children: [
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Tooltip(
                              message: "Supprimer toutes les dates",
                              child: OutlinedButton.icon(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                    AssetColors.blueButton,
                                  ),
                                ),
                                icon: const Icon(Icons.delete),
                                onPressed: (ctl.seletedDays.isEmpty)
                                    ? null
                                    : () {
                                        ctl.seletedDays.clear();
                                        ctl.update();
                                      },
                                label: const Text("Vider"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
