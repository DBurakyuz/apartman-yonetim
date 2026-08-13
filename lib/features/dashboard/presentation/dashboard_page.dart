import 'package:final_project/features/auth/data/auth_repository.dart';
import 'package:final_project/features/dashboard/presentation/widgets/announcements_tab.dart';
import 'package:final_project/features/dashboard/presentation/widgets/due_tab.dart';
import 'package:final_project/features/dashboard/presentation/widgets/tickets_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Tasarım Sistemi İçe Aktarımları
import 'package:final_project/core/theme/app_colors.dart';
import 'package:final_project/core/theme/theme_provider.dart';

import 'package:final_project/shared/design_system/atoms/app_app_bar.dart';
import 'package:final_project/shared/design_system/atoms/app_button.dart';

// Modüller & Sağlayıcılar
import 'package:final_project/features/auth/domain/app_user.dart';
import 'package:final_project/features/auth/presentation/providers/auth_provider.dart';

import 'package:final_project/features/announcements/data/announcement_repository.dart';

// Parçalanmış Widget'lar (Lego Parçaları)

import 'package:final_project/features/announcements/presentation/widgets/add_announcement_dialog.dart';



class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(currentUserProvider);
    final appUser = userState.value;

    final isAdmin = appUser?.role == UserRole.admin ;
    final activeApt = ref.watch(activeApartmentProvider);
    final apartmentsAsync = ref.watch(uniqueApartmentsProvider);

    // Eğer appUser veya apartmentId henüz yüklenmediyse bekle
    if (appUser?.apartmentId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 2. Duyurular Nehrini (Canlı Yayın) Dinliyoruz (ŞİFRELİ)
    final announcementsAsync = ref.watch(announcementsStreamProvider(activeApt));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        
        // SADECE ADMİN VEYA YÖNETİCİ İSE YENİ DUYURU EKLEME BUTONU (FAB) GÖSTER!
        floatingActionButton: (appUser?.role == UserRole.admin || appUser?.role == UserRole.manager)
            ? FloatingActionButton(
                backgroundColor: AppColors.buttonTextYellow,
                child: const Icon(Icons.add, color: Colors.black),
                onPressed: () {
                   showAddAnnouncementDialog(context, ref, appUser!);
                },
              )
            : null,
      
        // AppBar'ı tamamen kaldırdık. Her şeyi sayfanın gövdesine (body) modern bir şekilde diziyoruz.
        body: SafeArea(
          child: Column(
            children: [
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                                            // YÖNETİCİYSE AÇILIR MENÜ GÖSTER, DEĞİLSE SADECE KENDİ APARTMANININ ADINI YAZ
                    if (isAdmin)
                      apartmentsAsync.when(
                        data: (apartments) {
                          if (apartments.isEmpty) return const Text("Apartman Yok");
                          
                          // Eğer listede seçili apartman yoksa varsayılanı göster
                          String currentVal = apartments.contains(activeApt) 
                              ? activeApt 
                              : apartments.first;

                          return DropdownButton<String>(
                            value: currentVal,
                            underline: const SizedBox(), // Altındaki o çirkin çizgiyi gizler
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            items: apartments.map((String aptName) {
                              return DropdownMenuItem<String>(
                                value: aptName,
                                child: Text(aptName),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                // Yönetici yeni apartman seçtiğinde hafızaya (Provider) kaydet!
                                ref.read(selectedApartmentProvider.notifier).setApartment(newValue);
                              }
                            },
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (err, stack) => const Text("Hata!"),
                      )
                    else
                      Text(
                        appUser?.apartmentId ?? "Site Yönetim",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    Row(
                      children: [
                        // Gündüz / Gece Modu Butonux"
                        IconButton(
                          icon: Icon(
                            Theme.of(context).brightness == Brightness.dark 
                                ? Icons.light_mode 
                                : Icons.dark_mode,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          onPressed: () {
                            ref.read(themeNotifierProvider.notifier).toggleTheme();
                          },
                        ),
                        // Çıkış Yap Butonu
                        IconButton(
                          icon: const Icon(Icons.logout, color: Colors.redAccent),
                          onPressed: () {
                            ref.read(authRepositoryProvider).signOut(); 
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //SEKMELER
              TabBar(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.54),
                indicatorColor: Theme.of(context).primaryColor,
                dividerColor: Theme.of(context).dividerColor,
                tabs: const [
                  Tab(text: "Aidatlar"),
                  Tab(text: "Duyurular"),
                  Tab(text: 'Talepler'),
                ],
              ),

              // SEKMELERİN İÇERİKLERİ
              Expanded(
                child: TabBarView(
                  children: [ 
                    if(appUser != null) DueTab(appUser: appUser) else const SizedBox(),
                    const AnnouncementsTab(), 
                    const TicketsTab()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}