import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../models/trip.dart';
import '../../models/booking.dart';
import '../../themes/app_theme.dart';
import '../../providers/booking_provider.dart';
import 'package:uuid/uuid.dart';

class BookingsTab extends StatefulWidget {
  final Trip trip;

  const BookingsTab({super.key, required this.trip});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  BookingType? _selectedType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).loadBookings(widget.trip.id);
    });
  }

  List<Booking> _getFilteredBookings(List<Booking> bookings) {
    if (_selectedType == null) {
      return bookings;
    }
    return bookings.where((booking) => booking.type == _selectedType).toList();
  }

  List<Booking> _getSortedBookings(List<Booking> bookings) {
    final filtered = _getFilteredBookings(bookings);
    filtered.sort((a, b) {
      // Sort by status (confirmed first)
      if (a.status != b.status) {
        final statusOrder = [
          BookingStatus.confirmed,
          BookingStatus.pending,
          BookingStatus.cancelled,
        ];
        return statusOrder.indexOf(a.status).compareTo(statusOrder.indexOf(b.status));
      }
      // Then by date
      if (a.bookingDate != null && b.bookingDate != null) {
        return a.bookingDate!.compareTo(b.bookingDate!);
      } else if (a.bookingDate != null) {
        return -1;
      } else if (b.bookingDate != null) {
        return 1;
      }
      return 0;
    });
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        if (bookingProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }

        final sortedBookings = _getSortedBookings(bookingProvider.bookings);

        return Scaffold(
          body: Column(
            children: [
              _buildFilterBar(bookingProvider.bookings, bookingProvider),
              Expanded(
                child: bookingProvider.bookings.isEmpty
                    ? _buildEmptyState(bookingProvider)
                    : RefreshIndicator(
                        onRefresh: () => bookingProvider.loadBookings(widget.trip.id),
                        color: AppTheme.primaryColor,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: sortedBookings.length,
                          itemBuilder: (context, index) {
                            return _buildBookingItem(sortedBookings[index], bookingProvider);
                          },
                        ),
                      ),
              ),
            ],
          ),
          floatingActionButton: Container(
            decoration: AppTheme.glowingButtonDecoration,
            child: FloatingActionButton.extended(
              onPressed: () => _showAddBookingDialog(bookingProvider),
              icon: const Icon(Iconsax.add),
              label: const Text(
                'Booking',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterBar(List<Booking> bookings, BookingProvider bookingProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: Text('All (${bookings.length})'),
                    selected: _selectedType == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedType = null;
                      });
                    },
                    selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                    checkmarkColor: AppTheme.primaryColor,
                    labelStyle: TextStyle(
                      color: _selectedType == null ? AppTheme.primaryColor : null,
                      fontWeight: _selectedType == null ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ...BookingType.values.map((type) {
                    final isSelected = _selectedType == type;
                    final count = bookings.where((b) => b.type == type).length;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text('${type.displayName} ($count)'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? type : null;
                          });
                        },
                        selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                        checkmarkColor: AppTheme.primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? AppTheme.primaryColor : null,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BookingProvider bookingProvider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.airplane,
                size: 48,
                color: AppTheme.secondaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Bookings Yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Keep track of your flights, hotels, and activities!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: AppTheme.glowingButtonDecoration,
              child: ElevatedButton.icon(
                onPressed: () => _showAddBookingDialog(bookingProvider),
                icon: const Icon(Iconsax.add),
                label: const Text(
                  'Add First Booking',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingItem(Booking booking, BookingProvider bookingProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getTypeColor(booking.type).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showBookingDetailsBottomSheet(booking, bookingProvider),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getTypeColor(booking.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getTypeIcon(booking.type),
                  color: _getTypeColor(booking.type),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          booking.type.displayName,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        if (booking.bookingDate != null) ...[
                          const SizedBox(width: 8),
                          Icon(
                            Iconsax.calendar_1,
                            size: 12,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${booking.bookingDate!.day}/${booking.bookingDate!.month}/${booking.bookingDate!.year}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(booking.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getStatusColor(booking.status).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  booking.status.displayName,
                  style: TextStyle(
                    color: _getStatusColor(booking.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingDetailsBottomSheet(Booking booking, BookingProvider bookingProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _getTypeColor(booking.type).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getTypeIcon(booking.type),
                            color: _getTypeColor(booking.type),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Booking Details',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                booking.type.displayName,
                                style: TextStyle(
                                  color: _getTypeColor(booking.type),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      booking.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (booking.description.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        booking.description,
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(booking.status).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _getStatusColor(booking.status).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  booking.status.displayName,
                                  style: TextStyle(
                                    color: _getStatusColor(booking.status),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (booking.bookingDate != null) ...[
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.calendar_1,
                                      size: 16,
                                      color: AppTheme.textSecondary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${booking.bookingDate!.day}/${booking.bookingDate!.month}/${booking.bookingDate!.year}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (booking.vendor.isNotEmpty || booking.confirmationNumber.isNotEmpty || booking.amount > 0) ...[
                      const SizedBox(height: 20),
                      if (booking.vendor.isNotEmpty) ...[
                        Text(
                          'Vendor',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(booking.vendor),
                        const SizedBox(height: 12),
                      ],
                      if (booking.confirmationNumber.isNotEmpty) ...[
                        Text(
                          'Confirmation Number',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(booking.confirmationNumber),
                        const SizedBox(height: 12),
                      ],
                      if (booking.amount > 0) ...[
                        Text(
                          'Amount',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.trip.defaultCurrency} ${booking.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showEditBookingDialog(booking, bookingProvider);
                            },
                            icon: const Icon(Iconsax.edit_2),
                            label: const Text('Edit'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              Navigator.pop(context);
                              await bookingProvider.deleteBooking(booking.id);
                            },
                            icon: const Icon(Iconsax.trash),
                            label: const Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppTheme.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Color _getTypeColor(BookingType type) {
    switch (type) {
      case BookingType.flight:
        return Colors.blue;
      case BookingType.hotel:
        return Colors.purple;
      case BookingType.activity:
        return Colors.orange;
      case BookingType.transport:
        return Colors.green;
      case BookingType.restaurant:
        return Colors.red;
      case BookingType.other:
        return AppTheme.textSecondary;
    }
  }

  IconData _getTypeIcon(BookingType type) {
    switch (type) {
      case BookingType.flight:
        return Iconsax.airplane;
      case BookingType.hotel:
        return Iconsax.building_4;
      case BookingType.activity:
        return Iconsax.camera;
      case BookingType.transport:
        return Iconsax.car;
      case BookingType.restaurant:
        return Iconsax.cup;
      case BookingType.other:
        return Iconsax.bookmark;
    }
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return Colors.green;
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.cancelled:
        return AppTheme.error;
    }
  }

  void _showAddBookingDialog(BookingProvider bookingProvider) {
    _showBookingDialog(bookingProvider: bookingProvider);
  }

  void _showEditBookingDialog(Booking booking, BookingProvider bookingProvider) {
    _showBookingDialog(booking: booking, bookingProvider: bookingProvider);
  }

  void _showBookingDialog({Booking? booking, BookingProvider? bookingProvider}) {
    final isEdit = booking != null;
    final titleController = TextEditingController(text: booking?.title ?? '');
    final descriptionController = TextEditingController(text: booking?.description ?? '');
    final vendorController = TextEditingController(text: booking?.vendor ?? '');
    final confirmationController = TextEditingController(text: booking?.confirmationNumber ?? '');
    final amountController = TextEditingController(
      text: booking?.amount.toString() ?? '',
    );
    
    BookingType selectedType = booking?.type ?? BookingType.flight;
    BookingStatus selectedStatus = booking?.status ?? BookingStatus.pending;
    DateTime? selectedDate = booking?.bookingDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.surfaceDark
                : AppTheme.surfaceLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Iconsax.airplane,
                              color: AppTheme.secondaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isEdit ? 'Edit Booking' : 'Add New Booking',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Booking Title',
                          labelStyle: TextStyle(color: AppTheme.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        autofocus: true,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<BookingType>(
                        value: selectedType,
                        decoration: InputDecoration(
                          labelText: 'Booking Type',
                          labelStyle: TextStyle(color: AppTheme.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        items: BookingType.values
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Row(
                                    children: [
                                      Icon(_getTypeIcon(type), size: 16),
                                      const SizedBox(width: 8),
                                      Text(type.displayName),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setModalState(() {
                              selectedType = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description (Optional)',
                          labelStyle: TextStyle(color: AppTheme.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: vendorController,
                        decoration: InputDecoration(
                          labelText: 'Vendor/Company (Optional)',
                          labelStyle: TextStyle(color: AppTheme.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: confirmationController,
                        decoration: InputDecoration(
                          labelText: 'Confirmation Number (Optional)',
                          labelStyle: TextStyle(color: AppTheme.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'Amount (${widget.trip.defaultCurrency})',
                          labelStyle: TextStyle(color: AppTheme.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<BookingStatus>(
                        value: selectedStatus,
                        decoration: InputDecoration(
                          labelText: 'Status',
                          labelStyle: TextStyle(color: AppTheme.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        items: BookingStatus.values
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(status),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(status.displayName),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setModalState(() {
                              selectedStatus = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime.now().subtract(const Duration(days: 365)),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: Theme.of(context).colorScheme.copyWith(
                                    primary: AppTheme.primaryColor,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null) {
                            setModalState(() {
                              selectedDate = date;
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.calendar_1,
                                color: AppTheme.primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                selectedDate == null
                                    ? 'Set Booking Date (Optional)'
                                    : 'Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                style: TextStyle(
                                  color: selectedDate == null 
                                    ? AppTheme.textSecondary 
                                    : Theme.of(context).textTheme.bodyMedium?.color,
                                ),
                              ),
                              const Spacer(),
                              if (selectedDate != null)
                                IconButton(
                                  icon: Icon(
                                    Iconsax.close_circle,
                                    color: AppTheme.textSecondary,
                                  ),
                                  onPressed: () {
                                    setModalState(() {
                                      selectedDate = null;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: AppTheme.textSecondary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              decoration: AppTheme.glowingButtonDecoration,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (titleController.text.trim().isEmpty) return;

                                  final bookingItem = Booking(
                                    id: booking?.id ?? const Uuid().v4(),
                                    tripId: widget.trip.id,
                                    title: titleController.text.trim(),
                                    type: selectedType,
                                    description: descriptionController.text.trim(),
                                    bookingDate: selectedDate,
                                    vendor: vendorController.text.trim(),
                                    confirmationNumber: confirmationController.text.trim(),
                                    amount: double.tryParse(amountController.text.trim()) ?? 0.0,
                                    status: selectedStatus,
                                    createdAt: booking?.createdAt ?? DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );

                                  final provider = bookingProvider ?? Provider.of<BookingProvider>(context, listen: false);
                                  if (booking != null) {
                                    await provider.updateBooking(bookingItem);
                                  } else {
                                    await provider.createBooking(bookingItem);
                                  }
                                  
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  isEdit ? 'Update Booking' : 'Add Booking',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension BookingTypeExtension on BookingType {
  String get displayName {
    switch (this) {
      case BookingType.flight:
        return 'Flight';
      case BookingType.hotel:
        return 'Hotel';
      case BookingType.activity:
        return 'Activity';
      case BookingType.transport:
        return 'Transport';
      case BookingType.restaurant:
        return 'Restaurant';
      case BookingType.other:
        return 'Other';
    }
  }
}

extension BookingStatusExtension on BookingStatus {
  String get displayName {
    switch (this) {
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }
}