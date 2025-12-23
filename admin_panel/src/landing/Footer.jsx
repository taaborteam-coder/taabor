import React from 'react';
import { useTranslation } from 'react-i18next';
import { Link as ScrollLink } from 'react-scroll';
import { Link as RouterLink } from 'react-router-dom';
import { Facebook, Twitter, Instagram, Linkedin } from 'lucide-react';

export default function Footer() {
    const { t } = useTranslation();

    return (
        <footer className="bg-slate-900 text-white pt-16 pb-8 border-t border-slate-800">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
                    <div className="col-span-1 md:col-span-2">
                        <div className="flex items-center gap-2 mb-4">
                            <div className="w-8 h-8 bg-indigo-600 rounded-lg flex items-center justify-center text-white font-bold text-lg">
                                T
                            </div>
                            <span className="font-bold text-2xl">Taabor</span>
                        </div>
                        <p className="text-slate-400 max-w-sm mb-6">
                            The smartest way to manage queues and book appointments. Save time and grow your business with Taabor.
                        </p>
                        <div className="flex gap-4">
                            <a href="#" className="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:bg-indigo-600 hover:text-white transition-all">
                                <Facebook size={20} />
                            </a>
                            <a href="#" className="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:bg-indigo-600 hover:text-white transition-all">
                                <Twitter size={20} />
                            </a>
                            <a href="#" className="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:bg-indigo-600 hover:text-white transition-all">
                                <Instagram size={20} />
                            </a>
                            <a href="#" className="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:bg-indigo-600 hover:text-white transition-all">
                                <Linkedin size={20} />
                            </a>
                        </div>
                    </div>

                    <div>
                        <h4 className="font-bold text-lg mb-6">Product</h4>
                        <ul className="space-y-4">
                            <li><ScrollLink to="features" smooth={true} className="text-slate-400 hover:text-indigo-400 cursor-pointer">Features</ScrollLink></li>
                            <li><ScrollLink to="how-it-works" smooth={true} className="text-slate-400 hover:text-indigo-400 cursor-pointer">How it Works</ScrollLink></li>
                            <li><ScrollLink to="stats" smooth={true} className="text-slate-400 hover:text-indigo-400 cursor-pointer">Pricing</ScrollLink></li>
                            <li><ScrollLink to="faq" smooth={true} className="text-slate-400 hover:text-indigo-400 cursor-pointer">FAQ</ScrollLink></li>
                        </ul>
                    </div>

                    <div>
                        <h4 className="font-bold text-lg mb-6">Legal</h4>
                        <ul className="space-y-4">
                            <li><RouterLink to="/privacy-policy" className="text-slate-400 hover:text-indigo-400 cursor-pointer">Privacy Policy</RouterLink></li>
                            <li><RouterLink to="/terms-of-service" className="text-slate-400 hover:text-indigo-400 cursor-pointer">Terms of Service</RouterLink></li>
                            <li><a href="#" className="text-slate-400 hover:text-indigo-400 cursor-pointer">Cookie Policy</a></li>
                            <li><RouterLink to="/login" className="text-slate-400 hover:text-indigo-400 cursor-pointer">Admin Login</RouterLink></li>
                        </ul>
                    </div>
                </div>

                <div className="pt-8 border-t border-slate-800 text-center md:text-left flex flex-col md:flex-row justify-between items-center bg-slate-900">
                    <p className="text-slate-500 text-sm">© {new Date().getFullYear()} Taabor Inc. All rights reserved.</p>
                    <div className="flex gap-6 mt-4 md:mt-0">
                        <div className="flex items-center gap-2">
                            <span className="w-2 h-2 rounded-full bg-green-500"></span>
                            <span className="text-slate-400 text-sm">Systems Operational</span>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    );
}
