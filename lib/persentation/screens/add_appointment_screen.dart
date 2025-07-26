// 📄 feature/add-appointment-ui — فرم ثبت نوبت با طراحی حرفه‌ای و Riverpod

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../data/repositories/appointment_repository_impl.dart';
import '../../data/datasources/local/appointment_local_datasource_impl.dart';
import '../../domain/usecasess/add_appointment.dart';

final addAppointmentProvider = Provider<AddAppointment>((ref) {
  final repo = AppointmentRepositoryImpl(AppointmentLocalDataSource.instance);
  return AddAppointment(repo);
});

final appointmentFormLoadingProvider = StateProvider<bool>((ref) => false);

class AddAppointmentScreen extends ConsumerWidget {
  final int businessId;
  final String businessName;

  AddAppointmentScreen({
    super.key,
    required this.businessId,
    required this.businessName,
  });

  final _clientController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(appointmentFormLoadingProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('ثبت نوبت برای $businessName')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'مشخصات نوبت:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _clientController,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'نام مشتری',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _dateController,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'تاریخ (مثلاً 1403/04/15)',
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _timeController,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'ساعت (مثلاً 14:30)',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(isLoading ? 'در حال ذخیره...' : 'ذخیره نوبت'),
                  onPressed: isLoading
                      ? null
                      : () async {
                          final client = _clientController.text.trim();
                          final date = _dateController.text.trim();
                          final time = _timeController.text.trim();

                          if (client.isEmpty || date.isEmpty || time.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('لطفاً همه فیلدها را پر کنید')),
                            );
                            return;
                          }

                          ref.read(appointmentFormLoadingProvider.notifier).state = true;

                          final addAppointment = ref.read(addAppointmentProvider);
                          final appointment = AppointmentEntity(
                            businessId: businessId,
                            clientName: client,
                            date: date,
                            time: time,
                          );
                          await addAppointment(appointment);

                          ref.read(appointmentFormLoadingProvider.notifier).state = false;

                          _clientController.clear();
                          _dateController.clear();
                          _timeController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('نوبت با موفقیت ثبت شد ✅')),
                          );
                        },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}