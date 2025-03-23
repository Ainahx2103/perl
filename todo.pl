#!/usr/bin/perl
use strict;
use warnings;
use File::Slurp;

# Define the file to store tasks
my $task_file = "tasks.txt";

# Load tasks from file (if exists)
my @tasks = read_file($task_file, chomp => 1) if -e $task_file;

# Main menu loop
while (1) {
    print "\n📌 To-Do List Manager\n";
    print "1️⃣ Add Task\n";
    print "2️⃣ List Tasks\n";
    print "3️⃣ Mark Task as Done ✅\n";
    print "4️⃣ Remove Task ❌\n";
    print "5️⃣ Exit 🚪\n";
    print "Choose an option: ";

    my $choice = <STDIN>;
    chomp($choice);

    if ($choice == 1) {
        add_task();
    } elsif ($choice == 2) {
        list_tasks();
    } elsif ($choice == 3) {
        mark_task_done();
    } elsif ($choice == 4) {
        remove_task();
    } elsif ($choice == 5) {
        save_tasks();
        print "👋 Goodbye!\n";
        last;
    } else {
        print "❌ Invalid option. Try again.\n";
    }
}

# Function to add a new task
sub add_task {
    print "📝 Enter task description: ";
    my $task = <STDIN>;
    chomp($task);
    push @tasks, "[ ] $task";  # Mark as not done
    save_tasks();
    print "✅ Task added!\n";
}

# Function to list all tasks
sub list_tasks {
    if (@tasks) {
        print "\n📃 Your Tasks:\n";
        for my $i (0..$#tasks) {
            print "$i. $tasks[$i]\n";
        }
    } else {
        print "📭 No tasks found!\n";
    }
}

# Function to mark a task as done
sub mark_task_done {
    list_tasks();
    print "✔ Enter task number to mark as done: ";
    my $num = <STDIN>;
    chomp($num);

    if (defined $tasks[$num] && $tasks[$num] =~ /^\[ \] /) {
        $tasks[$num] =~ s/^\[ \]/[✓]/;  # Mark as done
        save_tasks();
        print "🎉 Task marked as done!\n";
    } else {
        print "❌ Invalid task number or already completed.\n";
    }
}

# Function to remove a task
sub remove_task {
    list_tasks();
    print "🗑 Enter task number to remove: ";
    my $num = <STDIN>;
    chomp($num);

    if (defined $tasks[$num]) {
        splice(@tasks, $num, 1);
        save_tasks();
        print "🗑 Task removed!\n";
    } else {
        print "❌ Invalid task number.\n";
    }
}

# Function to save tasks to file
sub save_tasks {
    write_file($task_file, map { "$_\n" } @tasks);
}
