<%
  '/* ============================================================================== */
  '/* =   PAGE : 라이브버리 PAGE                                                   = */
  '/* = -------------------------------------------------------------------------- = */
  '/* =   Copyright (c)  2016  NHN KCP Inc.   All Rights Reserved.                 = */
  '/* ============================================================================== */

  '/* ============================================================================== */
  '/* =   지불 연동 CLASS                                                          = */
  '/* ============================================================================== */

    Class c_PayPlusData

    '/* -------------------------------------------------------------------- */
    '/* -   처리 결과 값                                                   - */
    '/* -------------------------------------------------------------------- */
        Dim m_retData
        Dim arrData
        Dim arrRetData
        Dim arrDataList()

    '/* -------------------------------------------------------------------- */
    '/* -   초기화                                                         - */
    '/* -------------------------------------------------------------------- */
        Function InitialTX()

            m_retData   = ""
            arrData     = ""
            arrRetData  = ""

        End Function

    '/* -------------------------------------------------------------------- */
    '/* -   MOD DATA 전문 구성                                             - */
    '/* -------------------------------------------------------------------- */
        Function mf_set_modx_data(name,value)

            if isnull(m_retData) or m_retData = "" then
                m_retData = "mod_data="
                
            end if

            if value <> "" then
                m_retData = m_retData & name & "=" & value & chr(31)

                mf_set_modx_data = m_retData
                
            end if

            mf_set_modx_data = m_retData

        End Function

	'/* -------------------------------------------------------------------- */
    '/* -   ORDER DATA 전문 구성                                           - */
    '/* -------------------------------------------------------------------- */
        Function mf_set_ordr_data( name, value )

            if m_retData = "" and value <> "" then
                m_retData = "ordr_data="
                m_retData = m_retData & name & "=" & value
                mf_set_ordr_data = m_retData
            else
                if value <> "" then
                    m_retData = m_retData & chr(31) & name & "=" & value
                    mf_set_ordr_data = m_retData
                end if
            end if

            mf_set_ordr_data = m_retData

        End Function

	'/* -------------------------------------------------------------------- */
    '/* -   REQUEST DATA 전문 구성                                         - */
    '/* -------------------------------------------------------------------- */
        Function mf_set_req_data( value )

            if m_retData = "" and value <> "" then
                m_retData = value
                mf_set_req_data = m_retData
            else
                if value <> "" then
                    m_retData = m_retData & chr(28) & value
                    mf_set_req_data = m_retData
                end if
            end if

            mf_set_req_data = m_retData

        End Function

    '/* -------------------------------------------------------------------- */
    '/* -   RESULT DATA PARSING                                            - */
    '/* -------------------------------------------------------------------- */
        Function mf_set_res_data(name)

            k = 0
            Redim arrDataList(k+1)
            arrData = Split(name,chr(31))

            for i=0 to Ubound(arrData)
                arrRetData = Split(arrData(i),"=")

                for j=0 to Ubound(arrRetData)
                    Redim preserve arrDataList(k+1)
                    arrDataList(k) = Trim(arrRetData(j))
                    k = k+1
                next

            next

        End Function

    '/* -------------------------------------------------------------------- */
    '/* -   RESULT DATA 전문 구성                                          - */
    '/* -------------------------------------------------------------------- */
        Function mf_get_data(name)

            for i=0 to Ubound(arrDataList)
                if StrComp(name,arrDataList(i)) = 0 then
                    mf_get_data = arrDataList(i+1)
                end if
            next

        End Function

    End Class
%>