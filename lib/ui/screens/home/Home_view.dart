import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelmate/models/mytrips/Data.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/color_constants.dart';
import 'Home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (model) {
        model.getAllTrips();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorConstants.mainwhite,
          appBar: AppBar(
            backgroundColor: ColorConstants.primaryRed,
            centerTitle: true,
            title: Text(
              "Home",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carousel Slider
                  model.isloading
                      ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 220,
                      width: double.maxFinite,
                      color: Colors.grey,
                    ),
                  )
                      : CarouselSlider(
                    items: List.generate(
                      model.allTrips!.length,
                          (index) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: double.infinity,
                            imageUrl: "${model.baseUrl}${model.allTrips![index].image}",
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.primaryRed,
                              ),
                            ),
                            errorWidget: (context, url, error) => const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      height: 220,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Upcoming Trips Title
                  Text(
                    "Upcoming Trips",
                    style: GoogleFonts.roboto(
                      color: ColorConstants.mainblack,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Upcoming Trips List
                  model.isloading
                      ? _buildShimmerGrid()
                      : _buildTripsGrid(model),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        mainAxisExtent: 340,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Center(child: Container(width: 100, height: 16, color: Colors.grey)),
                const SizedBox(height: 5),
                Container(width: 100, height: 16, color: Colors.grey),
                Container(width: 100, height: 16, color: Colors.grey),
                Container(width: 100, height: 16, color: Colors.grey),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }

  Widget _buildTripsGrid(HomeViewModel model) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        mainAxisExtent: 340,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            model.navigatetripView(model.allTrips![index]);
          },
          child: UpComingTripCard(
            myTrip:model.allTrips![index],
            model: model,
            tripName: model.allTrips![index].tripName ?? "No trip name",
            seats: "${model.allTrips![index].groupSize}",
            fromDate: "${model.allTrips![index].fromDate}",
            toDate: "${model.allTrips![index].toDate}",
            imageUrl: "${model.allTrips![index].image}",
            tripUserId: "${model.allTrips![index].user}", // Pass the trip's user ID
            currentUserId: model.userid, // Pass the current user's ID
          ),
        );
      },
      itemCount: model.allTrips!.length,
    );
  }
}

class UpComingTripCard extends StatelessWidget {
  const UpComingTripCard({
    super.key,
    required this.model,
    required this.imageUrl,
    required this.tripName,
    required this.seats,
    required this.fromDate,
    required this.toDate,
    required this.tripUserId, // Trip's user ID
    required this.currentUserId, required this.myTrip // Current user's ID
  });

  final HomeViewModel model;
  final String imageUrl;
  final String tripName;
  final String seats;
  final String fromDate;
  final String toDate;
  final String tripUserId;
  final int currentUserId;
  final MyTrip myTrip;

  @override
  Widget build(BuildContext context) {
     bool isOwnTrip = currentUserId == tripUserId; // Check if the trip belongs to the current user
print(tripUserId);
print(currentUserId);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trip Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.grey,
              child: CachedNetworkImage(
                height: 150,
                fit: BoxFit.cover,
                width: double.maxFinite,
                imageUrl: "${model.baseUrl}$imageUrl",
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: ColorConstants.primaryRed),
                ),
                errorWidget: (context, url, error) => const SizedBox(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Trip Name
          Text(
            tripName,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          // Seats & Dates
          Text(
            "Seats: $seats",
            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "From: $fromDate",
            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "To: $toDate",
            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          // Conditional Button
          Center(
            child: ElevatedButton(
              onPressed: () {

                  model.navigatetripView(myTrip);

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isOwnTrip==true ? Colors.blue : Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(double.infinity, 45),
              ),
              child: Text(
                isOwnTrip==true ? "Chat Now" : "view",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}