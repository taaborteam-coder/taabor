import React, { useState } from 'react';
import { X, MapPin } from 'lucide-react';
import { MapContainer, TileLayer, Marker, useMapEvents } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';
import ImageUpload from './ImageUpload';
import { uploadService } from '../services/uploadService';

// Fix Leaflet default marker icon issue
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
    iconRetinaUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon-2x.png',
    iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon.png',
    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-shadow.png',
});

function LocationMarker({ position, setPosition }) {
    useMapEvents({
        click(e) {
            setPosition(e.latlng);
        },
    });

    return position === null ? null : <Marker position={position} />;
}

export default function AddBusinessModal({ isOpen, onClose, onSubmit }) {
    const [formData, setFormData] = useState({
        name: '',
        ownerName: '',
        category: 'salon',
        address: '',
        phone: '',
        latitude: null,
        longitude: null,
        logoUrl: '',
        coverUrl: ''
    });
    const [logoFile, setLogoFile] = useState(null);
    const [coverFile, setCoverFile] = useState(null);
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [mapPosition, setMapPosition] = useState(null);

    // Default center (Riyadh, Saudi Arabia)
    const defaultCenter = [24.7136, 46.6753];

    const handleMapClick = (latlng) => {
        setMapPosition(latlng);
        setFormData({
            ...formData,
            latitude: latlng.lat,
            longitude: latlng.lng
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setIsSubmitting(true);
        try {
            let logoUrl = '';
            let coverUrl = '';

            // Upload images if selected
            if (logoFile) {
                logoUrl = await uploadService.uploadFile(logoFile, 'business_logos');
            }
            if (coverFile) {
                coverUrl = await uploadService.uploadFile(coverFile, 'business_covers');
            }

            const businessData = {
                ...formData,
                logoUrl,
                coverUrl
            };

            await onSubmit(businessData);
            setFormData({
                name: '', ownerName: '', category: 'salon', address: '', phone: '',
                latitude: null, longitude: null, logoUrl: '', coverUrl: ''
            });
            setMapPosition(null);
            setLogoFile(null);
            setCoverFile(null);
            onClose();
        } catch (error) {
            console.error('Error adding business:', error);
            alert('فشل إضافة العمل');
        } finally {
            setIsSubmitting(false);
        }
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4" onClick={onClose}>
            <div className="bg-white rounded-2xl p-6 w-full max-w-2xl max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()} dir="rtl">
                <div className="flex justify-between items-center mb-6">
                    <h2 className="text-2xl font-bold text-gray-800">إضافة عمل جديد</h2>
                    <button onClick={onClose} className="text-gray-400 hover:text-gray-600">
                        <X size={24} />
                    </button>
                </div>

                <form onSubmit={handleSubmit} className="space-y-4">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">اسم العمل</label>
                            <input
                                type="text"
                                required
                                value={formData.name}
                                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                            />
                        </div>

                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">اسم المالك</label>
                            <input
                                type="text"
                                required
                                value={formData.ownerName}
                                onChange={(e) => setFormData({ ...formData, ownerName: e.target.value })}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                            />
                        </div>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">النوع</label>
                            <select
                                value={formData.category}
                                onChange={(e) => setFormData({ ...formData, category: e.target.value })}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                            >
                                <option value="salon">صالون</option>
                                <option value="clinic">عيادة</option>
                                <option value="restaurant">مطعم</option>
                                <option value="laboratory">مختبر</option>
                            </select>
                        </div>

                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">رقم الهاتف</label>
                            <input
                                type="tel"
                                value={formData.phone}
                                onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                            />
                        </div>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <ImageUpload
                            label="شعار العمل (Logo)"
                            onChange={setLogoFile}
                            value={null}
                        />
                        <ImageUpload
                            label="صورة الغلاف (Cover)"
                            onChange={setCoverFile}
                            value={null}
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">العنوان</label>
                        <input
                            type="text"
                            required
                            value={formData.address}
                            onChange={(e) => setFormData({ ...formData, address: e.target.value })}
                            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2 flex items-center gap-2">
                            <MapPin size={18} className="text-indigo-600" />
                            اختر الموقع على الخريطة
                        </label>
                        <div className="h-64 rounded-lg overflow-hidden border border-gray-300">
                            <MapContainer
                                center={defaultCenter}
                                zoom={13}
                                style={{ height: '100%', width: '100%' }}
                            >
                                <TileLayer
                                    attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
                                    url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                                />
                                <LocationMarker position={mapPosition} setPosition={handleMapClick} />
                            </MapContainer>
                        </div>
                        {mapPosition && (
                            <p className="text-xs text-gray-500 mt-2">
                                الإحداثيات: {mapPosition.lat.toFixed(6)}, {mapPosition.lng.toFixed(6)}
                            </p>
                        )}
                    </div>

                    <div className="flex gap-3 mt-6 pt-4 border-t">
                        <button
                            type="submit"
                            disabled={isSubmitting || !mapPosition}
                            className="flex-1 bg-indigo-600 text-white py-2 rounded-lg hover:bg-indigo-700 disabled:bg-indigo-300"
                        >
                            {isSubmitting ? 'جاري الإضافة...' : 'إضافة'}
                        </button>
                        <button
                            type="button"
                            onClick={onClose}
                            className="flex-1 bg-gray-100 text-gray-700 py-2 rounded-lg hover:bg-gray-200"
                        >
                            إلغاء
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}
