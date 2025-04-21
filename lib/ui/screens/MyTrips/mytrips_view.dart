import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/color_constants.dart';
import 'mytrips_viewmodel.dart';

class MyTripsView extends StatelessWidget {
  const MyTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyTripsViewModel>.reactive(
      onViewModelReady: (model) {
        model.getAllTrips();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.primaryRed,
            elevation: 4,
            title: Text(
              "My Trips",
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            color: Colors.grey[100],
            child: model.isloading
                ? _buildShimmerLayout(model) // Show shimmer during loading
                : model.allTrips!.isEmpty
                ? _buildNoTripsView() // Show "No Trips" if no data
                : _buildTripsContent(model), // Show trips content
          ),
        );
      },
      viewModelBuilder: () => MyTripsViewModel(),
    );
  }

  // Shimmer layout during loading
  Widget _buildShimmerLayout(MyTripsViewModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerCarousel(),
            const SizedBox(height: 20),
            _buildShimmerGrid(model),
          ],
        ),
      ),
    );
  }

  // No trips available view
  Widget _buildNoTripsView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50), // Add some top spacing
          Icon(
            Icons.card_travel,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            "No Trips Available",
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Plan your next adventure!",
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // Trips content when data is available
  Widget _buildTripsContent(MyTripsViewModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarouselSlider(model),
            const SizedBox(height: 20),
            Text(
              "My Trips",
              style: GoogleFonts.roboto(
                color: ColorConstants.mainblack,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildTripsGrid(model),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCarousel() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider(MyTripsViewModel model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CarouselSlider(
        items: List.generate(
          model.allTrips!.length,
              (index) => ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: double.infinity,
              imageUrl: "${model.baseUrl}${model.allTrips![index].image}",
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: ColorConstants.primaryRed),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.error, color: Colors.grey, size: 50),
              ),
            ),
          ),
        ),
        options: CarouselOptions(
          height: 220,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.85,
          autoPlayInterval: const Duration(seconds: 3),
        ),
      ),
    );
  }

  Widget _buildShimmerGrid(MyTripsViewModel model) {
    return RefreshIndicator(
      onRefresh: (){
        return model.getAllTrips();
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          mainAxisExtent: 300,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 100, height: 16, color: Colors.grey),
                        const SizedBox(height: 8),
                        Container(width: 80, height: 12, color: Colors.grey),
                        const SizedBox(height: 5),
                        Container(width: 80, height: 12, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTripsGrid(MyTripsViewModel model) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        mainAxisExtent: 300,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: model.allTrips!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            model.navigatetripView(model.allTrips![index]);
          },
          child: MyTripCard(
            placeName: "${model.allTrips![index].location}",
            tripName: model.allTrips![index].tripName ?? '',
            date: "${model.allTrips![index].fromDate}",
            imageUrl: "${model.baseUrl}${model.allTrips![index].image}",
          ),
        );
      },
    );
  }
}

class MyTripCard extends StatelessWidget {
  const MyTripCard({
    super.key,
    required this.tripName,
    required this.placeName,
    required this.date,
    required this.imageUrl,
  });

  final String tripName;
  final String placeName;
  final String date;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: double.infinity,
              height: 130,
              imageUrl: imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: ColorConstants.primaryRed),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.error, color: Colors.grey, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tripName.isNotEmpty ? tripName : "Unnamed Trip",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.mainblack,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        placeName,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: ElevatedButton(
              onPressed: () {
                // Add chat functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryRed,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(double.infinity, 40),
              ),
              child: Text(
                "Chat Now",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
