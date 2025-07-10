// 📄 feature/add-business-ui — افزودن کسب‌وکار با UI حرفه‌ای + Riverpod (راست‌چین و فارسی)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/business_entity.dart';
import '../../data/repositories/business_repository_impl.dart';
import '../../data/datasources/business_local_datasource.dart';
import '../../domain/usecasess/add_business.dart';

final addBusinessProvider = Provider<AddBusiness>((ref) {
  final repo = BusinessRepositoryImpl(BusinessLocalDataSource.instance);
  return AddBusiness(repo);
});

final formLoadingProvider = StateProvider<bool>((ref) => false);

class AddBusinessScreen extends ConsumerWidget {
  AddBusinessScreen({super.key});

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(formLoadingProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('افزودن کسب‌وکار')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'اطلاعات کسب‌وکار را وارد کنید:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _nameController,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'نام کسب‌وکار',
                  prefixIcon: Icon(Icons.business),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'شماره تماس',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _addressController,
                maxLines: 2,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'آدرس',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _descController,
                maxLines: 3,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'توضیحات',
                  prefixIcon: Icon(Icons.description),
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
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Icon(Icons.save),
                  label: Text(isLoading ? 'در حال ذخیره...' : 'ذخیره کسب‌وکار'),
                  onPressed: isLoading
                      ? null
                      : () async {
                          final name = _nameController.text.trim();
                          final phone = _phoneController.text.trim();
                          final address = _addressController.text.trim();
                          final desc = _descController.text.trim();

                          if (name.isEmpty || phone.isEmpty || address.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('نام، شماره تماس و آدرس اجباری هستند!')),
                            );
                            return;
                          }

                          ref.read(formLoadingProvider.notifier).state = true;

                          final addBusiness = ref.read(addBusinessProvider);
                          final entity = BusinessEntity(
                            name: name,
                            phone: phone,
                            address: address,
                            description: desc,
                          );
                          await addBusiness(entity);

                          ref.read(formLoadingProvider.notifier).state = false;

                          _nameController.clear();
                          _phoneController.clear();
                          _addressController.clear();
                          _descController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('با موفقیت ذخیره شد ✅')),
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