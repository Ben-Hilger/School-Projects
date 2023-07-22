import type IFormatter from "./IFormatter";
import { injectable } from "inversify";

@injectable()
export default class Formatter implements IFormatter {
    
    formatDateShort(date: Date): string {
        let formatter = new Intl.DateTimeFormat(undefined, {
            year: "numeric",
            month: "numeric",
            day: "numeric",
        })
        return formatter.format(date)
    }

    formatDateLong(date: Date): string {
        let formatter = new Intl.DateTimeFormat(undefined, {
            weekday: "long",
            year: "numeric",
            month: "long",
            day: "numeric",
        });
        return formatter.format(date)
    }
    
    formatCurrency(numberToFormat: number): string {
        let formatter = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        });
        return formatter.format(numberToFormat);
    }

    
}