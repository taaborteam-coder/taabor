import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Menu, X, Download, Globe } from 'lucide-react';
import { Link } from 'react-scroll';
import { useNavigate } from 'react-router-dom';

export default function Navbar() {
    const { t, i18n } = useTranslation();
    const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
    const navigate = useNavigate();
    const isRTL = i18n.dir() === 'rtl';

    const navLinks = [
        { name: t('home'), to: 'hero' },
        { name: t('features'), to: 'features' },
        { name: t('how_it_works'), to: 'how-it-works' },
        { name: t('stats'), to: 'stats' },
    ];

    const toggleLanguage = () => {
        const newLang = i18n.language === 'en' ? 'ar' : 'en';
        i18n.changeLanguage(newLang);
    };

    return (
        <nav className="fixed w-full bg-white/80 backdrop-blur-md z-50 border-b border-gray-100">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex justify-between items-center h-20">
                    {/* Logo */}
                    <div className="flex-shrink-0 flex items-center gap-2 cursor-pointer" onClick={() => window.scrollTo(0, 0)}>
                        <div className="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center text-white font-bold text-xl">
                            T
                        </div>
                        <span className="font-bold text-2xl text-gray-900">Taabor</span>
                    </div>

                    {/* Desktop Menu */}
                    <div className="hidden md:flex items-center space-x-8 rtl:space-x-reverse">
                        {navLinks.map((link) => (
                            <Link
                                key={link.name}
                                to={link.to}
                                smooth={true}
                                duration={500}
                                offset={-80}
                                className="text-gray-600 hover:text-indigo-600 font-medium cursor-pointer transition-colors"
                            >
                                {link.name}
                            </Link>
                        ))}
                    </div>

                    {/* Actions */}
                    <div className="hidden md:flex items-center gap-4">
                        <button
                            onClick={toggleLanguage}
                            className="p-2 text-gray-500 hover:text-indigo-600 transition-colors"
                            aria-label="Change Language"
                        >
                            <Globe size={20} />
                        </button>
                        <button
                            onClick={() => navigate('/login')}
                            className="bg-gray-100 text-gray-900 px-5 py-2.5 rounded-xl font-semibold hover:bg-gray-200 transition-colors"
                        >
                            {t('merchant_login')}
                        </button>
                        <Link
                            to="download"
                            smooth={true}
                            duration={500}
                            className="bg-indigo-600 text-white px-5 py-2.5 rounded-xl font-semibold hover:bg-indigo-700 transition-colors shadow-lg shadow-indigo-200 flex items-center gap-2 cursor-pointer"
                        >
                            <Download size={18} />
                            {t('download_app')}
                        </Link>
                    </div>

                    {/* Mobile Menu Button */}
                    <div className="md:hidden flex items-center gap-4">
                        <button
                            onClick={toggleLanguage}
                            className="p-2 text-gray-500"
                        >
                            <Globe size={20} />
                        </button>
                        <button
                            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
                            className="text-gray-600 p-2"
                        >
                            {mobileMenuOpen ? <X size={24} /> : <Menu size={24} />}
                        </button>
                    </div>
                </div>
            </div>

            {/* Mobile Menu */}
            {mobileMenuOpen && (
                <div className="md:hidden bg-white border-t border-gray-100 absolute w-full left-0 shadow-xl">
                    <div className="px-4 pt-2 pb-6 space-y-2">
                        {navLinks.map((link) => (
                            <Link
                                key={link.name}
                                to={link.to}
                                smooth={true}
                                className="block px-3 py-3 rounded-md text-base font-medium text-gray-700 hover:text-indigo-600 hover:bg-gray-50 cursor-pointer"
                                onClick={() => setMobileMenuOpen(false)}
                            >
                                {link.name}
                            </Link>
                        ))}
                        <div className="pt-4 border-t border-gray-100 mt-4 flex flex-col gap-3">
                            <button
                                onClick={() => navigate('/login')}
                                className="w-full bg-gray-100 text-gray-900 px-5 py-3 rounded-xl font-semibold text-center"
                            >
                                {t('merchant_login')}
                            </button>
                            <button className="w-full bg-indigo-600 text-white px-5 py-3 rounded-xl font-semibold text-center">
                                {t('download_app')}
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </nav>
    );
}
