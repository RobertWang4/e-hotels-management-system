package com.ehotels.service;

import com.ehotels.model.Booking;
import com.ehotels.model.Customer;
import com.ehotels.model.Hotel;
import com.ehotels.model.Renting;
import com.ehotels.model.Room;
import com.ehotels.repository.CustomerRepository;
import com.ehotels.repository.HotelRepository;
import com.ehotels.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservationSnapshotService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private HotelRepository hotelRepository;

    public void populateBookingSnapshot(Booking booking) {
        Customer customer = customerRepository.findById(booking.getCustomerId()).orElseThrow();
        Room room = roomRepository.findById(booking.getRoomId()).orElseThrow();
        Hotel hotel = hotelRepository.findById(room.getHotelId()).orElseThrow();

        booking.setCustomerNameSnapshot(customer.getFullName());
        booking.setCustomerIdNumberSnapshot(customer.getIdNumber());
        booking.setRoomNumberSnapshot(room.getRoomNumber());
        booking.setHotelNameSnapshot(hotel.getName());
        booking.setRoomPriceSnapshot(room.getPrice());
        booking.setRoomCapacitySnapshot(room.getCapacity());
    }

    public void populateRentingSnapshot(Renting renting) {
        Customer customer = customerRepository.findById(renting.getCustomerId()).orElseThrow();
        Room room = roomRepository.findById(renting.getRoomId()).orElseThrow();
        Hotel hotel = hotelRepository.findById(room.getHotelId()).orElseThrow();

        renting.setCustomerNameSnapshot(customer.getFullName());
        renting.setCustomerIdNumberSnapshot(customer.getIdNumber());
        renting.setRoomNumberSnapshot(room.getRoomNumber());
        renting.setHotelNameSnapshot(hotel.getName());
        renting.setRoomPriceSnapshot(room.getPrice());
        renting.setRoomCapacitySnapshot(room.getCapacity());
    }

    public void copyBookingSnapshotToRenting(Booking booking, Renting renting) {
        renting.setCustomerNameSnapshot(booking.getCustomerNameSnapshot());
        renting.setCustomerIdNumberSnapshot(booking.getCustomerIdNumberSnapshot());
        renting.setRoomNumberSnapshot(booking.getRoomNumberSnapshot());
        renting.setHotelNameSnapshot(booking.getHotelNameSnapshot());
        renting.setRoomPriceSnapshot(booking.getRoomPriceSnapshot());
        renting.setRoomCapacitySnapshot(booking.getRoomCapacitySnapshot());
    }
}
