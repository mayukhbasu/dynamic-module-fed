import { Component, ViewEncapsulation } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'ng-mf-nx-welcome',
  standalone: true,
  imports: [CommonModule],
  template: `
   Hello Mayukh
  `,
  styles: [],
  encapsulation: ViewEncapsulation.None,
})
export class NxWelcomeComponent {}
