package gov.nih.nci.evs.reportwriter.utils;

import java.io.*;
import java.util.*;

import org.apache.log4j.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;

/**
 * <!-- LICENSE_TEXT_START -->
 * Copyright 2008,2009 NGIT. This software was developed in conjunction 
 * with the National Cancer Institute, and so to the extent government 
 * employees are co-authors, any rights in such works shall be subject 
 * to Title 17 of the United States Code, section 105.
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions 
 * are met:
 *   1. Redistributions of source code must retain the above copyright 
 *      notice, this list of conditions and the disclaimer of Article 3, 
 *      below. Redistributions in binary form must reproduce the above 
 *      copyright notice, this list of conditions and the following 
 *      disclaimer in the documentation and/or other materials provided 
 *      with the distribution.
 *   2. The end-user documentation included with the redistribution, 
 *      if any, must include the following acknowledgment:
 *      "This product includes software developed by NGIT and the National 
 *      Cancer Institute."   If no such end-user documentation is to be
 *      included, this acknowledgment shall appear in the software itself,
 *      wherever such third-party acknowledgments normally appear.
 *   3. The names "The National Cancer Institute", "NCI" and "NGIT" must 
 *      not be used to endorse or promote products derived from this software.
 *   4. This license does not authorize the incorporation of this software
 *      into any third party proprietary programs. This license does not 
 *      authorize the recipient to use any trademarks owned by either NCI 
 *      or NGIT 
 *   5. THIS SOFTWARE IS PROVIDED "AS IS," AND ANY EXPRESSED OR IMPLIED 
 *      WARRANTIES, (INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *      OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE) ARE 
 *      DISCLAIMED. IN NO EVENT SHALL THE NATIONAL CANCER INSTITUTE,
 *      NGIT, OR THEIR AFFILIATES BE LIABLE FOR ANY DIRECT, INDIRECT, 
 *      INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
 *      BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
 *      LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
 *      CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
 *      LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
 *      ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
 *      POSSIBILITY OF SUCH DAMAGE.
 * <!-- LICENSE_TEXT_END -->
 */

/**
 * @author EVS Team (Kim Ong, David Yee)
 * @version 1.0
 */

public class FileUtil {
    private static Logger _logger = Logger.getLogger(FileUtil.class);
    private static final int MAX_WIDTH = 30;

    private static Vector<String> parseData(String line, String tab) {
        Vector<String> data_vec = new Vector<String>();
        // RWW GF20743, delimiters are returned as tokens
        // first value could be a tab
        StringTokenizer st = new StringTokenizer(line, tab, true);
        boolean lastWasDelim = true;
        while (st.hasMoreTokens()) {
            String value = st.nextToken();
            if (value.equals(tab)) {
                if (lastWasDelim) {
                    data_vec.add("");
                }
                lastWasDelim = true;
            } else {
                data_vec.add(value);
                lastWasDelim = false;
            }
        }
        return data_vec;
    }

    public static Boolean[] findWrappedColumns(String textfile,
        String delimiter, int maxLength) throws Exception {
        File file = new File(textfile);

        FileInputStream fis = null;
        BufferedInputStream bis = null;
        DataInputStream dis = null;
        Boolean[] a = null;

        fis = new FileInputStream(file);
        bis = new BufferedInputStream(fis);
        dis = new DataInputStream(bis);

        int rownum = 0;
        while (dis.available() != 0) {
            String line = dis.readLine();
            if (line.length() <= 0)
                continue;
            Vector<String> v = parseData(line, delimiter);
            if (rownum == 0) {
                a = new Boolean[v.size()];
                for (int i = 0; i < v.size(); i++) {
                    a[i] = Boolean.FALSE;
                }
            } else {
                for (int i = 0; i < v.size(); i++) {
                    String s = (String) v.elementAt(i);
                    if (s.length() > maxLength && a[i].equals(Boolean.FALSE)) {
                        // _logger.debug("\n" + line);
                        // _logger.debug("i: " + i + " " + s);
                        a[i] = Boolean.TRUE;
                    }
                }
            }
            rownum++;
        }
        return a;
    }

    public static Boolean convertToExcel(String textfile, String delimiter)
            throws Exception {
        int k = textfile.indexOf(".txt");
        String excelfile = textfile.substring(0, k) + ".xls";
        return convertToExcel(textfile, delimiter, excelfile);
    }

    public static Boolean convertToExcel(String textfile, String delimiter,
        String excelfile) throws Exception {
        Boolean[] a = findWrappedColumns(textfile, delimiter, MAX_WIDTH);
        // RWW, The max number of columns allowed in an
        // Excel spreadsheet is 256
        int[] b = new int[255];
        for (int i = 0; i < 255; i++) {
            b[i] = 0;
        }
        File file = new File(textfile);

        String absolutePath = file.getAbsolutePath();
        _logger.debug("Absolute Path: " + absolutePath);

        String filename = file.getName();
        _logger.debug("filename: " + filename);

        int m = filename.indexOf(".");
        String workSheetLabel = filename.substring(0, m);
        int n = workSheetLabel.indexOf("__");
        workSheetLabel = workSheetLabel.substring(0, n);
        _logger.debug("workSheetLabel: " + workSheetLabel);

        if (workSheetLabel.compareTo("") == 0)
            return Boolean.FALSE;

        String pathName = file.getPath();
        _logger.debug("Path: " + pathName);

        FileInputStream fis = null;
        BufferedInputStream bis = null;
        DataInputStream dis = null;

        fis = new FileInputStream(file);
        bis = new BufferedInputStream(fis);
        dis = new DataInputStream(bis);

        FileOutputStream fout = new FileOutputStream(excelfile);
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet ws = wb.createSheet(workSheetLabel);

        HSSFCellStyle toprow = wb.createCellStyle();
        HSSFCellStyle cs = wb.createCellStyle();

        // RWW GF20673 shade top row
        HSSFFont font = wb.createFont();
        font.setColor(HSSFColor.BLACK.index);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        toprow.setFont(font);
        toprow.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        toprow.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        toprow.setAlignment(HSSFCellStyle.VERTICAL_CENTER);
        toprow.setWrapText(true);

        cs.setWrapText(true);
        cs.setAlignment(HSSFCellStyle.ALIGN_JUSTIFY);
        //cs.setAlignment(HSSFCellStyle.VERTICAL_CENTER);

        HSSFRow wr = null;
        int rownum = 0;
        while (dis.available() != 0) {
            String line = dis.readLine();
            // line = line.trim(); RWW - 090512 first value could be empty
            // (\t)
            if (line.length() <= 0)
                continue;
            Vector<String> v = parseData(line, delimiter);
            wr = ws.createRow(rownum);
            wr.setHeightInPoints(rownum == 0 ? 40 : 15);

            for (int i = 0; i < v.size(); i++) {
                HSSFCell wc = wr.createCell(i);
                if (rownum == 0) {
                    wc.setCellStyle(toprow);
                } else if (a[i].equals(Boolean.TRUE)) {
                    wc.setCellStyle(cs);
                    wc.setCellType(HSSFCell.CELL_TYPE_STRING);
                }

                String s = (String) v.elementAt(i);
                s = s.trim();

                if (s.length() > b[i]) {
                    b[i] = s.length();
                }
                if (s.equals("")) {
                    s = null;
                }
                wc.setCellValue(s);
            }
            rownum++;
        }

        /*
         * for( int i=0; i < 255; i++) { if( b[i] != 0) {
         * _logger.debug("Max for column " + i + ": " + b[i]); } }
         * _logger.debug("----------");
         */

        // RWW GF20673 assign widths
        // 315 is the magic number for this font and size
        for (int i = 0; i < 255; i++) {
            if (b[i] != 0) {
                int colWidth = b[i] * 315;
                // fileds like definition run long, some sanity required
                if (colWidth > 20000) {
                    colWidth = 20000;
                }
                // _logger.debug("Calculated width for column " + i +
                // ": " + colWidth);
                ws.setColumnWidth(i, colWidth);
            }
        }

        // RWW GF20673 freeze top row
        ws.createFreezePane(0, 1, 0, 1);
        wb.write(fout);
        fout.close();
        return Boolean.TRUE;
    }

    public static void main(String[] args) {
        try {
            String delimiter = "\t";
            FileUtil.convertToExcel(args[0], delimiter, args[1]);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
