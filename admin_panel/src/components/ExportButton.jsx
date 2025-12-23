import React from 'react';
import { Download } from 'lucide-react';
import { useToast } from '../context/ToastContext';
import * as XLSX from 'xlsx';

export default function ExportButton({ data, filename = 'report' }) {
    const { showToast } = useToast();

    const handleExport = () => {
        try {
            if (!data || data.length === 0) {
                showToast('No data to export', 'warning');
                return;
            }

            const wb = XLSX.utils.book_new();
            const ws = XLSX.utils.json_to_sheet(data);
            XLSX.utils.book_append_sheet(wb, ws, "Sheet1");
            XLSX.writeFile(wb, `${filename}_${new Date().toISOString().split('T')[0]}.xlsx`);

            showToast('Report exported successfully', 'success');
        } catch (error) {
            console.error(error);
            showToast('Failed to export report', 'error');
        }
    };

    return (
        <button
            onClick={handleExport}
            className="flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-medium transition-colors"
        >
            <Download size={18} />
            Export Excel
        </button>
    );
}
