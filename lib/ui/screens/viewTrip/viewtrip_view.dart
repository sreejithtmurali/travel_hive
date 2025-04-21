import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:my_travelmate/ui/screens/viewTrip/viewtrip_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/assets.gen.dart';
import '../../../constants/color_constants.dart';
import '../../../models/mytrips/Data.dart';

class TripView extends StatelessWidget {
  final MyTrip myTrip;

  const TripView({required this.myTrip, super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TripViewModel>.reactive(
      onViewModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                floating: false,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "${model.myTrip.tripName}",
                    maxLines: 2,
                    style: GoogleFonts.share(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: "${model.baseUrl}${model.myTrip.image}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.primaryRed,
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          Assets.images.bg.path, // Add a placeholder image in assets
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: ColorConstants.primaryRed,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.location_pin, color: Colors.white),
                    onPressed: () => _launchMap("${model.myTrip.location}"),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               "${model.myTrip.description}",
                                maxLines: model.lines,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.share(
                                  color: Colors.grey[800],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    model.toggleDescription();
                                  },
                                  child: Text(
                                    model.lines == 2 ? "Read More" : "Read Less",
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => _launchMap("${model.myTrip.location}"),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://www.shambix.com/wp-content/uploads/2019/09/google-maps-world-smartsync-at-for-google-world-map.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTripDetailsTable(model),
                      const SizedBox(height: 16),
                      _buildActionButtons(context,model),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => TripViewModel(myTrip: myTrip),
    );
  }

  Widget _buildTripDetailsTable(TripViewModel model) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          border: TableBorder.all(color: Colors.grey[300]!, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          children: [
            _buildTableRow("Travel Type", "${model.myTrip.travelType}"),
            _buildTableRow("Group Size", model.myTrip.groupSize.toString()),
            _buildTableRow("Available Seats", model.myTrip.availableSeat.toString()),
            _buildTableRow("Budget", model.myTrip.budget.toString()),
            _buildTableRow("Date From", model.myTrip.fromDate.toString()),
            _buildTableRow("Date To", model.myTrip.toDate.toString()),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: GoogleFonts.share(fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: GoogleFonts.share()),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context,TripViewModel model) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
           bool? s=await model.joingrop();
           if(s==true){
             navigationService.navigateTo(Routes.groupsView,arguments: GroupChatViewArguments(roomId: model.myTrip.chatRoom!.id!));
           }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
            elevation: 3,
          ),
          child: const Text(
            "Join Now",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: null, // Disabled state
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
            elevation: 3,
          ),
          child: const Text(
            "Chat Now",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<void> _launchMap(String location) async {
    final googleUrl = Uri.parse(location);
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}