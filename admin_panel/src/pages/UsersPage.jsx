import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Search, UserPlus, Filter, MoreHorizontal, Shield, Mail, Calendar, User, Loader2, Trash2, Edit } from 'lucide-react';
import { userService } from '../services/userService';
import AddUserModal from '../components/AddUserModal';
import EditUserModal from '../components/EditUserModal';
import { getAuth, createUserWithEmailAndPassword } from 'firebase/auth';
import { useToast } from '../context/ToastContext';



const UsersPage = () => {
    const { t, i18n } = useTranslation();
    const isRTL = i18n.dir() === 'rtl';
    const [searchTerm, setSearchTerm] = useState('');
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [showAddModal, setShowAddModal] = useState(false);
    const [showEditModal, setShowEditModal] = useState(false);
    const [editingUser, setEditingUser] = useState(null);
    const toast = useToast();

    React.useEffect(() => {
        const fetchUsers = async () => {
            try {
                setLoading(true);
                const data = await userService.getUsers();
                setUsers(data);
            } catch (err) {
                console.error(err);
                setError('Failed to load users');
            } finally {
                setLoading(false);
            }
        };

        fetchUsers();
    }, []);

    const handleAddUser = async (userData) => {
        try {
            const auth = getAuth();
            const userCredential = await createUserWithEmailAndPassword(auth, userData.email, userData.password);
            await userService.addUserWithId(userCredential.user.uid, {
                name: userData.name,
                email: userData.email,
                role: userData.role,
                status: 'Active'
            });
            const updatedUsers = await userService.getUsers();
            setUsers(updatedUsers);
            toast.success('تم إضافة المستخدم بنجاح');
        } catch (error) {
            console.error('Error adding user:', error);
            toast.error('فشل إضافة المستخدم: ' + error.message);
            throw error;
        }
    };

    const handleDeleteUser = async (userId) => {
        if (!window.confirm('هل أنت متأكد من حذف هذا المستخدم؟')) return;
        try {
            await userService.deleteUser(userId);
            setUsers(users.filter(u => u.id !== userId));
            toast.success('تم حذف المستخدم بنجاح');
        } catch (error) {
            console.error('Error deleting user:', error);
            toast.error('فشل حذف المستخدم');
        }
    };

    const handleEditUser = (user) => {
        setEditingUser(user);
        setShowEditModal(true);
    };

    const handleUpdateUser = async (userId, updateData) => {
        try {
            await userService.updateUser(userId, updateData);
            const updatedUsers = await userService.getUsers();
            setUsers(updatedUsers);
            toast.success('تم تحديث المستخدم بنجاح');
        } catch (error) {
            console.error('Error updating user:', error);
            toast.error('فشل تحديث المستخدم');
            throw error;
        }
    };

    const filteredUsers = users.filter(user =>
        (user.name?.toLowerCase() || '').includes(searchTerm.toLowerCase()) ||
        (user.email?.toLowerCase() || '').includes(searchTerm.toLowerCase())
    );

    if (loading) {
        return (
            <div className="flex justify-center items-center h-96">
                <Loader2 className="w-8 h-8 animate-spin text-indigo-600" />
            </div>
        );
    }

    return (
        <div className="space-y-6">
            {/* Header */}
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h1 className="text-2xl font-bold text-gray-800">{t('users_management')}</h1>
                    <p className="text-gray-500 mt-1">{t('users_subtitle')}</p>
                </div>
                <button
                    onClick={() => setShowAddModal(true)}
                    className="bg-indigo-600 text-white px-5 py-2.5 rounded-xl hover:bg-indigo-700 transition-colors shadow-lg shadow-indigo-200 flex items-center gap-2 self-start md:self-auto"
                >
                    <UserPlus size={20} />
                    <span>{t('add_user')}</span>
                </button>
            </div>

            {/* Table Card */}
            <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">

                {/* Controls */}
                <div className="p-5 border-b border-gray-100 flex flex-col md:flex-row gap-4 bg-gray-50/50">
                    <div className="relative flex-1 max-w-md">
                        <Search className={`absolute ${isRTL ? 'right-3' : 'left-3'} top-1/2 transform -translate-y-1/2 text-gray-400`} size={18} />
                        <input
                            type="text"
                            placeholder={t('search_placeholder_user')}
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            className={`w-full ${isRTL ? 'pr-10 pl-4' : 'pl-10 pr-4'} py-2.5 bg-white border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all shadow-sm`}
                        />
                    </div>
                    <button className="flex items-center gap-2 px-4 py-2 bg-white border border-gray-200 rounded-xl text-gray-600 hover:bg-gray-50">
                        <Filter size={18} />
                        <span>Filter</span>
                    </button>
                </div>

                {/* Table */}
                <div className="overflow-x-auto">
                    <table className="w-full">
                        <thead className="bg-gray-50/50">
                            <tr>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-medium text-sm`}>{t('full_name')}</th>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-medium text-sm`}>{t('email')}</th>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-medium text-sm`}>{t('role')}</th>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-medium text-sm`}>{t('last_active')}</th>
                                <th className={`text-${isRTL ? 'right' : 'left'} py-4 px-6 text-gray-500 font-medium text-sm`}>{t('status')}</th>
                                <th className={`text-${isRTL ? 'left' : 'right'} py-4 px-6 text-gray-500 font-medium text-sm`}>{t('actions')}</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-gray-100">
                            {filteredUsers.map((user) => (
                                <tr key={user.id} className="hover:bg-gray-50/80 transition-colors">
                                    <td className="py-4 px-6">
                                        <div className="flex items-center gap-3">
                                            <div className="w-10 h-10 bg-gradient-to-br from-indigo-100 to-purple-100 rounded-full flex items-center justify-center text-indigo-600 font-bold">
                                                {user.name.charAt(0)}
                                            </div>
                                            <div>
                                                <p className="font-semibold text-gray-900">{user.name}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td className="py-4 px-6 text-gray-600">
                                        <div className="flex items-center gap-2">
                                            <Mail size={16} className="text-gray-400" />
                                            {user.email}
                                        </div>
                                    </td>
                                    <td className="py-4 px-6">
                                        <div className="flex items-center gap-2">
                                            <Shield size={16} className="text-gray-400" />
                                            <span className="text-gray-700">{t(`role_${user.role.toLowerCase()}`) || user.role}</span>
                                        </div>
                                    </td>
                                    <td className="py-4 px-6 text-gray-500 text-sm">
                                        <div className="flex items-center gap-2">
                                            <Calendar size={16} className="text-gray-400" />
                                            {user.lastActive}
                                        </div>
                                    </td>
                                    <td className="py-4 px-6">
                                        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${user.status === 'Active' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                                            }`}>
                                            {t(`user_${user.status.toLowerCase()}`)}
                                        </span>
                                    </td>
                                    <td className="py-4 px-6">
                                        <div className={`flex gap-2 justify-${isRTL ? 'start' : 'end'}`}>
                                            <button
                                                onClick={() => handleEditUser(user)}
                                                className="text-indigo-600 hover:text-indigo-800 p-2 hover:bg-indigo-50 rounded-lg transition-colors"
                                                title="تعديل"
                                            >
                                                <Edit size={18} />
                                            </button>
                                            <button
                                                onClick={() => handleDeleteUser(user.id)}
                                                className="text-red-600 hover:text-red-800 p-2 hover:bg-red-50 rounded-lg transition-colors"
                                                title="حذف"
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
            </div>

            <AddUserModal
                isOpen={showAddModal}
                onClose={() => setShowAddModal(false)}
                onSubmit={handleAddUser}
            />
        </div>
    );
};

export default UsersPage;
