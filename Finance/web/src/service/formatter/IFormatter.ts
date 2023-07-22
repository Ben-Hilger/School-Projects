
export default interface IFormatter {

    formatCurrency(nun: number): string;

    formatDateShort(date: Date): string;

    formatDateLong(date: Date): string;
}
