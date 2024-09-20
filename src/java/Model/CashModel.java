/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Acer
 */
public class CashModel {

    private Long openbalance;
    private Long debitamount;
    private String debitname;
    private Long cramount;
    private String crname;
    private Long netbalance;
    private Long totaldebit;
    private Long totalcredit;
    private String bankname;
    private Long deposit;
    private Long withdraw;
    private Long Balance;
    private Long bankbalance;
    private Long propblance;

    public String getDebitname() {
        return debitname;
    }

    public void setDebitname(String debitname) {
        this.debitname = debitname;
    }

    public String getCrname() {
        return crname;
    }

    public void setCrname(String crname) {
        this.crname = crname;
    }

    public Long getOpenbalance() {
        return openbalance;
    }

    public void setOpenbalance(Long openbalance) {
        this.openbalance = openbalance;
    }

    public Long getNetbalance() {
        return netbalance;
    }

    public void setNetbalance(Long netbalance) {
        this.netbalance = netbalance;
    }

    public Long getTotaldebit() {
        return totaldebit;
    }

    public void setTotaldebit(Long totaldebit) {
        this.totaldebit = totaldebit;
    }

    public Long getTotalcredit() {
        return totalcredit;
    }

    public void setTotalcredit(Long totalcredit) {
        this.totalcredit = totalcredit;
    }

    public String getBankname() {
        return bankname;
    }

    public void setBankname(String bankname) {
        this.bankname = bankname;
    }

    public Long getDebitamount() {
        return debitamount;
    }

    public void setDebitamount(Long debitamount) {
        this.debitamount = debitamount;
    }

    public Long getCramount() {
        return cramount;
    }

    public void setCramount(Long cramount) {
        this.cramount = cramount;
    }

    public Long getDeposit() {
        return deposit;
    }

    public void setDeposit(Long deposit) {
        this.deposit = deposit;
    }

    public Long getWithdraw() {
        return withdraw;
    }

    public void setWithdraw(Long withdraw) {
        this.withdraw = withdraw;
    }

    public Long getBalance() {
        return Balance;
    }

    public void setBalance(Long Balance) {
        this.Balance = Balance;
    }

    public Long getBankbalance() {
        return bankbalance;
    }

    public void setBankbalance(Long bankbalance) {
        this.bankbalance = bankbalance;
    }

    public Long getPropblance() {
        return propblance;
    }

    public void setPropblance(Long propblance) {
        this.propblance = propblance;
    }

}
