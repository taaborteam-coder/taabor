import React from 'react';
import Navbar from '../landing/Navbar';
import Footer from '../landing/Footer';

export default function TermsOfService() {
    return (
        <div className="min-h-screen bg-gray-50 font-sans">
            <Navbar />

            <main className="pt-32 pb-20 max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="bg-white rounded-3xl p-8 md:p-12 shadow-sm border border-gray-100">
                    <h1 className="text-4xl font-extrabold text-slate-900 mb-8">Terms of Service</h1>
                    <p className="text-slate-500 mb-8">Last updated: December 15, 2025</p>

                    <div className="prose prose-indigo max-w-none text-slate-600">
                        <h3>1. Agreement to Terms</h3>
                        <p>By accessing or using our Services, you agree to be bound by these Terms. If you do not agree to be bound by these Terms, you may not access or use the Services.</p>

                        <h3>2. Use of Services</h3>
                        <p>You represent that you are over the age of 18. The Company does not permit those under 18 to use the Service.</p>

                        <h3>3. User Accounts</h3>
                        <p>When you create an account with us, you must provide us information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.</p>

                        <h3>4. Termination</h3>
                        <p>We may terminate or suspend your Account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach these Terms of Service.</p>

                        <h3>5. Governing Law</h3>
                        <p>These Terms shall be governed and construed in accordance with the laws of Iraq, without regard to its conflict of law provisions.</p>
                    </div>
                </div>
            </main>

            <Footer />
        </div>
    );
}
