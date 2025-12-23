import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import LanguageDetector from 'i18next-browser-languagedetector';

const resources = {
    en: {
        translation: {
            "dashboard": "Dashboard",
            "businesses": "Businesses",
            "users": "Users",
            "analytics": "Analytics",
            "settings": "Settings",
            "overview": "Overview",
            "total_businesses": "Total Businesses",
            "total_users": "Total Users",
            "active_tickets": "Active Tickets",
            "revenue": "Revenue",
            "ticket_volume": "Ticket Volume (Last 7 Days)",
            "recent_businesses": "Recent Businesses",
            "view_all": "View All",
            "search": "Search...",
            "taabor_admin": "Taabor Admin",
            "status_active": "Active",
            "status_pending": "Pending",
            "status_suspended": "Suspended",
            "clinic": "Clinic",
            "salon": "Salon",
            "restaurant": "Restaurant",
            "laboratory": "Laboratory",

            // Business Page
            "business_management": "Business Management",
            "business_management_subtitle": "Manage shops, approvals, and accounts.",
            "add_business": "Add Business",
            "search_placeholder_biz": "Search by name, owner, or location...",
            "all_statuses": "All Statuses",
            "business_name": "Business Name",
            "owner": "Owner",
            "type": "Type",
            "status": "Status",
            "location": "Location",
            "actions": "Actions",
            "loading_businesses": "Loading businesses...",
            "delete_confirm": "Are you sure you want to delete this business?",
            "failed_update": "Failed to update status",
            "failed_delete": "Failed to delete business",
            "general": "General",
            "unknown": "Unknown",

            // Users Page
            "users_management": "Users Management",
            "users_subtitle": "Manage system users, roles, and status.",
            "add_user": "Add User",
            "search_placeholder_user": "Search by name, email, or role...",
            "full_name": "Full Name",
            "email": "Email",
            "role": "Role",
            "last_active": "Last Active",
            "role_admin": "Admin",
            "role_manager": "Manager",
            "role_support": "Support",
            "delete_user_confirm": "Are you sure you want to remove this user?",
            "user_active": "Active",
            "user_inactive": "Inactive",

            // Analytics Page
            "analytics_dashboard": "Analytics Dashboard",
            "analytics_subtitle": "Performance metrics and growth insights.",
            "revenue_overview": "Revenue Overview",
            "user_growth": "User Growth",
            "business_distribution": "Business Distribution",

            // Settings Page
            "settings_title": "Settings",
            "settings_subtitle": "Manage your application preferences.",
            "general_tab": "General",
            "notifications_tab": "Notifications",
            "security_tab": "Security",
            "app_name": "App Name",
            "language_default": "Default Language",
            "email_notifications": "Email Notifications",
            "push_notifications": "Push Notifications",
            "change_password": "Change Password",
            "save_changes": "Save Changes"
        }
    },
    ar: {
        translation: {
            "dashboard": "لوحة التحكم",
            "businesses": "الأعمال",
            "users": "المستخدمين",
            "analytics": "التحليلات",
            "settings": "الإعدادات",
            "overview": "نظرة عامة",
            "total_businesses": "إجمالي الأعمال",
            "total_users": "إجمالي المستخدمين",
            "active_tickets": "التذاكر النشطة",
            "revenue": "الإيرادات",
            "ticket_volume": "حجم التذاكر (آخر 7 أيام)",
            "recent_businesses": "الأعمال المضافة مؤخراً",
            "view_all": "عرض الكل",
            "search": "بحث...",
            "taabor_admin": "طابور أدمن",
            "status_active": "نشط",
            "status_pending": "قيد الانتظار",
            "status_suspended": "موقوف",
            "clinic": "عيادة",
            "salon": "صالون",
            "restaurant": "مطعم",
            "laboratory": "مختبر",

            // Business Page
            "business_management": "إدارة الأعمال",
            "business_management_subtitle": "إدارة المتاجر، الموافقات، والحسابات.",
            "add_business": "إضافة عمل جديد",
            "search_placeholder_biz": "ابحث بالاسم، المالك، أو الموقع...",
            "all_statuses": "كل الحالات",
            "business_name": "اسم العمل",
            "owner": "المالك",
            "type": "النوع",
            "status": "الحالة",
            "location": "الموقع",
            "actions": "الإجراءات",
            "loading_businesses": "جاري تحميل الأعمال...",
            "delete_confirm": "هل أنت متأكد أنك تريد حذف هذا العمل؟",
            "failed_update": "فشل تحديث الحالة",
            "failed_delete": "فشل حذف العمل",
            "general": "عام",
            "unknown": "غير معروف",

            // Users Page
            "users_management": "إدارة المستخدمين",
            "users_subtitle": "إدارة مستخدمي النظام، الصلاحيات، والحالة.",
            "add_user": "إضافة مستخدم",
            "search_placeholder_user": "ابحث بالاسم، البريد، أو الصلاحية...",
            "full_name": "الاسم الكامل",
            "email": "البريد الإلكتروني",
            "role": "الصلاحية",
            "last_active": "آخر ظهور",
            "role_admin": "مدير",
            "role_manager": "مشرف",
            "role_support": "دعم فني",
            "delete_user_confirm": "هل أنت متأكد أنك تريد حذف هذا المستخدم؟",
            "user_active": "نشط",
            "user_inactive": "غير نشط",

            // Analytics Page
            "analytics_dashboard": "لوحة التحليلات",
            "analytics_subtitle": "مؤشرات الأداء ورؤى النمو.",
            "revenue_overview": "نظرة عامة على الإيرادات",
            "user_growth": "نمو المستخدمين",
            "business_distribution": "توزيع الأعمال",

            // Settings Page
            "settings_title": "الإعدادات",
            "settings_subtitle": "إدارة تفضيلات التطبيق.",
            "general_tab": "عام",
            "notifications_tab": "الإشعارات",
            "security_tab": "الأمان",
            "app_name": "اسم التطبيق",
            "language_default": "اللغة الافتراضية",
            "email_notifications": "إشعارات البريد الإلكتروني",
            "push_notifications": "الإشعارات المنبثقة",
            "change_password": "تغيير كلمة المرور",
            "save_changes": "حفظ التغييرات"
        }
    },
    ku: {
        translation: {
            "dashboard": "داشبۆرد",
            "businesses": "کارەکان",
            "users": "بەکارهێنەران",
            "analytics": "شیکاری",
            "settings": "ڕێکخستنەکان",
            "overview": "تێڕوانینی گشتی",
            "total_businesses": "کۆی کارەکان",
            "total_users": "کۆی بەکارهێنەران",
            "active_tickets": "تیکێتە چالاکەکان",
            "revenue": "داهات",
            "ticket_volume": "قەبارەی تیکێت (٧ ڕۆژی ڕابردوو)",
            "recent_businesses": "کارە نوێکانی دواجار",
            "view_all": "بینی هەموو",
            "search": "گەڕان...",
            "taabor_admin": "ئەدمینی طابور",
            "status_active": "چالاک",
            "status_pending": "هەڵپەسێردراو",
            "status_suspended": "ڕاگیراو",
            "clinic": "کلینیک",
            "salon": "ساڵۆن",
            "restaurant": "چێشتخانە",
            "laboratory": "تاقیگە",

            // Business Page
            "business_management": "بەڕێوەبردنی کارەکان",
            "business_management_subtitle": "بەڕێوەبردنی فرۆشگاکان، ڕەزامەندییەکان، و هەژمارەکان.",
            "add_business": "زیادکردنی کار",
            "search_placeholder_biz": "گەڕان بەپێی ناو، خاوەن، یان شوێن...",
            "all_statuses": "هەموو دۆخەکان",
            "business_name": "ناوی کار",
            "owner": "خاوەن",
            "type": "جۆر",
            "status": "دۆخ",
            "location": "شوێن",
            "actions": "کردارەکان",
            "loading_businesses": "بارکردنی کارەکان...",
            "delete_confirm": "دڵنیایت لە سڕینەوەی ئەم کارە؟",
            "failed_update": "تازەکردنەوەی دۆخ سەرکەوتوو نەبوو",
            "failed_delete": "سڕینەوەی کار سەرکەوتوو نەبوو",
            "general": "گشتی",
            "unknown": "نەناسراو",

            // Users Page
            "users_management": "بەڕێوەبردنی بەکارهێنەران",
            "users_subtitle": "بەڕێوەبردنی بەکارهێنەرانی سیستم، ڕۆڵەکان، و دۆخ.",
            "add_user": "زیادکردنی بەکارهێنەر",
            "search_placeholder_user": "گەڕان بەپێی ناو، ئیمەیڵ، یان ڕۆڵ...",
            "full_name": "ناوی تەواو",
            "email": "ئیمەیڵ",
            "role": "ڕۆڵ",
            "last_active": "دوا دەرکەوتن",
            "role_admin": "ڕێپێدەر",
            "role_manager": "بەڕێوەبەر",
            "role_support": "پشتیوانی",
            "delete_user_confirm": "دڵنیایت لە سڕینەوەی ئەم بەکارهێنەرە؟",
            "user_active": "چالاک",
            "user_inactive": "ناچالاک",

            // Analytics Page
            "analytics_dashboard": "داشبۆردی شیکاری",
            "analytics_subtitle": "پێوەرەکانی ئەدائ و وردەکاریی گەشە.",
            "revenue_overview": "تێڕوانینی گشتی داهات",
            "user_growth": "گەشەی بەکارهێنەران",
            "business_distribution": "دابەشبوونی کارەکان",

            // Settings Page
            "settings_title": "ڕێکخستنەکان",
            "settings_subtitle": "بەڕێوەبردنی پەسەندکراوەکانی ئەپڵیکەیشن.",
            "general_tab": "گشتی",
            "notifications_tab": "ئاگادارکردنەوەکان",
            "security_tab": "ئاسایش",
            "app_name": "ناوی بەرنامە",
            "language_default": "زمانی بنەڕەتی",
            "email_notifications": "ئاگادارکردنەوەکانی ئیمەیڵ",
            "push_notifications": "ئاگادارکردنەوە دەمودەستەکان",
            "change_password": "گۆڕینی وشەی نهێنی",
            "save_changes": "هەڵگرتنی گۆڕانکارییەکان"
        }
    }
};

i18n
    .use(LanguageDetector)
    .use(initReactI18next)
    .init({
        resources,
        lng: 'ar', // Set Arabic as the default language
        fallbackLng: 'ar',
        interpolation: {
            escapeValue: false,
        },
        detection: {
            order: ['localStorage', 'navigator'],
            caches: ['localStorage']
        }
    });

export default i18n;
