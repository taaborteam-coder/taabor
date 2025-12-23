import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { Check, X, Search, Trash2, Plus, Filter, MapPin, User, Building2, CheckCircle2 } from 'lucide-react';
import { businessService } from '../services/businessService';
import AddBusinessModal from '../components/AddBusinessModal';
import { db } from '../firebase';
import { useToast } from '../context/ToastContext';

export default function BusinessPage() {
    const { t, i18n } = useTranslation();
    const isRTL = i18n.dir() === 'rtl';

    // Mock data for development if Firebase is empty/fails, or use real data logic
    const [businesses, setBusinesses] = useState([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');
    const [statusFilter, setStatusFilter] = useState('All');
    const [showAddModal, setShowAddModal] = useState(false);
    const toast = useToast();

    useEffect(() => {
        const fetchBusinesses = async () => {
            try {
                const businessList = await businessService.getBusinesses();
                const mappedList = businessList.map(b => ({
                    id: b.id,
                    name: b.name || t('unknown'),
                    owner: b.ownerName || t('unknown'),
                    type: b.category || 'General',
                    status: b.status || 'Pending',
                    location: b.address || t('unknown'),
                }));
                setBusinesses(mappedList);
            } catch (error) {
                console.error("Error fetching businesses:", error);
            } finally {
                setLoading(false);
            }
        };

        fetchBusinesses();
    }, [t]);

    const handleAddBusiness = async (businessData) => {
        try {
            await businessService.addBusiness(businessData);
            const updatedBusinesses = await businessService.getBusinesses();
            const mappedList = updatedBusinesses.map(b => ({
                id: b.id,
                name: b.name || t('unknown'),
                owner: b.ownerName || t('unknown'),
                type: b.category || 'General',
                status: b.status || 'Pending',
                location: b.address || t('unknown'),
            }));
            setBusinesses(mappedList);
            toast.success('تم إضافة العمل بنجاح');
        } catch (error) {
            console.error('Error adding business:', error);
            toast.error('فشل إضافة العمل');
            throw error;
        }
    };

    const handleToggleVerification = async (id, currentStatus) => {
        try {
            await businessService.toggleVerification(id, currentStatus);
            setBusinesses(businesses.map(b => b.id === id ? { ...b, isVerified: !currentStatus } : b));
            toast.success(currentStatus ? 'تم إلغاء توثيق العمل' : 'تم توثيق العمل بنجاح');
        } catch (error) {
            console.error("Error toggling verification:", error);
            toast.error('فشل تغيير حالة التوثيق');
        }
    };

    const handleStatusChange = async (id, newStatus) => {
        try {
            await businessService.updateBusiness(id, { status: newStatus });
            setBusinesses(businesses.map(b => b.id === id ? { ...b, status: newStatus } : b));
            toast.success('تم تحديث الحالة بنجاح');
        } catch (error) {
            console.error("Error updating status:", error);
            toast.error(t('failed_update'));
        }
    };

    const handleDelete = async (id) => {
        if (!window.confirm(t('delete_confirm'))) return;
        try {
            await businessService.deleteBusiness(id);
            setBusinesses(businesses.filter(b => b.id !== id));
            toast.success('تم حذف العمل بنجاح');
        } catch (error) {
            console.error("Error deleting business:", error);
            toast.error(t('failed_delete'));
        }
    };

    const filteredBusinesses = businesses.filter(b => {
        const matchesSearch = b.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            b.owner.toLowerCase().includes(searchTerm.toLowerCase()) ||
            b.location.toLowerCase().includes(searchTerm.toLowerCase());
        const matchesStatus = statusFilter === 'All' || b.status === statusFilter;
        return matchesSearch && matchesStatus;
    });

    if (loading) {
        return (
            <div className="flex justify-center items-center h-64">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
            </div>
        );
    }

    return (
        <div className="space-y-6">
            {/* Page Header */}
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h1 className="text-2xl font-bold text-gray-800">{t('business_management')}</h1>
                    <p className="text-gray-500 mt-1">{t('business_management_subtitle')}</p>
                </div>
                <button
                    onClick={() => setShowAddModal(true)}
                    className="bg-indigo-600 text-white px-5 py-2.5 rounded-xl hover:bg-indigo-700 transition-colors shadow-lg shadow-indigo-200 flex items-center gap-2 self-start md:self-auto"
                >
                    <Plus size={20} />
                    <span>{t('add_business')}</span>
                </button>
            </div>

            {/* Content Card */}
            <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">

                {/* Filters & Search */}
                <div className="p-5 border-b border-gray-100 flex flex-col md:flex-row gap-4 justify-between bg-gray-50/50">
                    <div className="relative flex-1 max-w-md">
                        <Search className={`absolute ${isRTL ? 'right-3' : 'left-3'} top-1/2 transform -translate-y-1/2 text-gray-400`} size={18} />
                        <input
                            type="text"
                            placeholder={t('search_placeholder_biz')}
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            className={`w-full ${isRTL ? 'pr-10 pl-4' : 'pl-10 pr-4'} py-2.5 bg-white border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all shadow-sm`}
                        />
                    </div>

                    <div className="flex items-center gap-2">
                        <Filter size={18} className="text-gray-400" />
                        <select
                            value={statusFilter}
                            onChange={(e) => setStatusFilter(e.target.value)}
                            className="bg-white border border-gray-200 text-gray-700 text-sm rounded-xl p-2.5 focus:ring-indigo-500 focus:border-indigo-500 shadow-sm cursor-pointer outline-none"
                        >
                            <option value="All">{t('all_statuses')}</option>
                            <option value="Active">{t('status_active')}</option>
                            <option value="Pending">{t('status_pending')}</option>
                            <option value="Suspended">{t('status_suspended')}</option>
                        </select>
                    </div>
                </div>

                {/* Table */}
                <div className="overflow-x-auto">
                    <table className="w-full">
                        <thead className="bg-gray-50/50">
                            <tr>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-semibold text-sm`}>{t('business_name')}</th>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-semibold text-sm`}>{t('owner')}</th>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-semibold text-sm`}>{t('type')}</th>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-semibold text-sm`}>{t('status')}</th>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-semibold text-sm`}>{t('location')}</th>
                                <th className={`text-${isRTL ? 'left' : 'right'} py-4 px-6 text-gray-500 font-semibold text-sm`}>{t('actions')}</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-gray-100">
                            {filteredBusinesses.map((biz) => (
                                <tr key={biz.id} className="hover:bg-gray-50/80 transition-colors group">
                                    <td className="py-4 px-6">
                                        <div className="flex items-center gap-3">
                                            <div className="w-10 h-10 bg-indigo-50 rounded-lg flex items-center justify-center text-indigo-600 font-bold shrink-0">
                                                {biz.name.charAt(0)}
                                            </div>
                                            <span className="font-medium text-gray-900">{biz.name}</span>
                                            {biz.isVerified && (
                                                <CheckCircle2 size={16} className="text-blue-500 fill-blue-50" />
                                            )}
                                        </div>
                                    </td>
                                    <td className="py-4 px-6 text-gray-600">
                                        <div className="flex items-center gap-2">
                                            <User size={16} className="text-gray-400" />
                                            {biz.owner}
                                        </div>
                                    </td>
                                    <td className="py-4 px-6">
                                        <div className="flex items-center gap-2 text-gray-700">
                                            <Building2 size={16} className="text-gray-400" />
                                            <span>{t(biz.type.toLowerCase()) || biz.type}</span>
                                        </div>
                                    </td>
                                    <td className="py-4 px-6">
                                        <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium border ${biz.status === 'Active' ? 'bg-green-50 text-green-700 border-green-100' :
                                            biz.status === 'Pending' ? 'bg-amber-50 text-amber-700 border-amber-100' :
                                                'bg-red-50 text-red-700 border-red-100'
                                            }`}>
                                            <span className={`w-1.5 h-1.5 rounded-full mr-1.5 ${biz.status === 'Active' ? 'bg-green-500' :
                                                biz.status === 'Pending' ? 'bg-amber-500' :
                                                    'bg-red-500'
                                                }`}></span>
                                            {t(`status_${biz.status.toLowerCase()}`)}
                                        </span>
                                    </td>
                                    <td className="py-4 px-6 text-gray-600">
                                        <div className="flex items-center gap-2">
                                            <MapPin size={16} className="text-gray-400" />
                                            {biz.location}
                                        </div>
                                    </td>
                                    <td className="py-4 px-6">
                                        <div className={`flex items-center gap-2 ${isRTL ? 'justify-end' : 'justify-end'}`}>
                                            {biz.status === 'Pending' && (
                                                <>
                                                    <button
                                                        onClick={() => handleStatusChange(biz.id, 'Active')}
                                                        className="p-2 text-green-600 bg-green-50 hover:bg-green-100 rounded-lg transition-colors border border-green-200"
                                                        title={t('status_active')}
                                                    >
                                                        <Check size={18} />
                                                    </button>
                                                    <button
                                                        onClick={() => handleStatusChange(biz.id, 'Suspended')}
                                                        className="p-2 text-red-600 bg-red-50 hover:bg-red-100 rounded-lg transition-colors border border-red-200"
                                                        title="Reject"
                                                    >
                                                        <X size={18} />
                                                    </button>
                                                </>
                                            )}
                                            {biz.status === 'Active' && (
                                                <button
                                                    onClick={() => handleStatusChange(biz.id, 'Suspended')}
                                                    className="p-2 text-amber-600 bg-amber-50 hover:bg-amber-100 rounded-lg transition-colors border border-amber-200"
                                                    title={t('status_suspended')}
                                                >
                                                    <X size={18} />
                                                </button>
                                            )}
                                            <div className="w-px h-6 bg-gray-200 mx-1"></div>
                                            <button
                                                onClick={() => handleToggleVerification(biz.id, biz.isVerified)}
                                                className={`p-2 rounded-lg transition-colors ${biz.isVerified ? 'text-blue-600 bg-blue-50 hover:bg-blue-100' : 'text-gray-400 hover:text-blue-600 hover:bg-blue-50'}`}
                                                title={biz.isVerified ? 'إلغاء التوثيق' : 'توثيق'}
                                            >
                                                <CheckCircle2 size={18} />
                                            </button>
                                            <button
                                                onClick={() => handleDelete(biz.id)}
                                                className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-all"
                                            >
                                                <Trash2 size={18} />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>

                {/* Empty State */}
                {filteredBusinesses.length === 0 && (
                    <div className="p-10 text-center text-gray-500">
                        <div className="w-16 h-16 bg-gray-50 rounded-full flex items-center justify-center mx-auto mb-4">
                            <Search size={24} className="text-gray-300" />
                        </div>
                        <p>{t('search')}</p>
                    </div>
                )}
            </div>

            <AddBusinessModal
                isOpen={showAddModal}
                onClose={() => setShowAddModal(false)}
                onSubmit={handleAddBusiness}
            />
        </div>
    );
}
